#!/usr/bin/env python3
# -*- coding utf-8 -*-

"""
Add meaningful readme
"""

import subprocess
import sys
import os

def exec_cmake(dirname: str, env_cc):
    """
    execute cmake and creates targets
    """
    dirname_default = dirname + '.default'
    dirname_admonition = dirname + '.admonition'
    res = subprocess.run(["cmake", '..'],
                         stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env_cc,
                         cwd=dirname_default)
    if os.name == 'nt': # on nt, stderr seems to be always empty
        res.stderr = res.stdout
    if res.stderr:
        print(res.stderr.decode('utf-8'))
        # missing error management

    #uhm... using pwd here does seem so wrong.. but without the relative path is broken
    #flags = '-DCMAKE_USER_MAKE_RULES_OVERRIDE=$(pwd)/../default_compiler_flags.txt'
    dirpath = os.getcwd()
    flags = '-DCMAKE_USER_MAKE_RULES_OVERRIDE=' + dirpath + '/default_compiler_flags.txt'
    res = subprocess.run(["cmake", flags, '..'],
                         stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env_cc,
                         cwd=dirname_admonition)
    if os.name == 'nt': # on nt, stderr seems to be always empty
        res.stderr = res.stdout
    if res.stderr:
        print(res.stderr.decode('utf-8'))
        # missing error management

def exec_test_i(dirname: str, target: str, expected_warn_or_err: str):
    """
    if compilation succeeds, executes target with admonition
    if compilation doesn't succeed, default might be more hardened than expected, so the test might add nothing
    """
    dirname_default = dirname + '.default'
    dirname_admonition = dirname + '.admonition'

    res = subprocess.run(["cmake", '--build', dirname_default, '--target', target],
                         stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if os.name == 'nt':
        res.stderr = res.stdout # on nt, stderr seems to be always empty
    if res.returncode != 0:
        print('failed to compile "%s", skip test' % target, file=sys.stderr)
        print(res.stderr.decode('utf-8'))
    else:
        res = subprocess.run(["cmake", '--build', dirname_admonition, '--target', target],
                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if os.name == 'nt': # on nt, stderr seems to be always empty
            res.stderr = res.stdout
        s_result = res.stderr.decode('utf-8')

        if expected_warn_or_err not in s_result:
            print('failed to trigger expected error on "%s"' % target, file=sys.stderr)
            print('admonition "%s" not found' % expected_warn_or_err, file=sys.stderr)
            print(s_result, file=sys.stderr)
        else:
            print('test "%s" passed' % target)

def exec_test(dirname, env_with_compiler, target_admonition, targets):
    """ create build dir, builds and checks admonitions """

    os.makedirs(dirname + '.admonition')
    os.makedirs(dirname + '.default')
    exec_cmake(dirname, env_with_compiler)

    for target, admonition in target_admonition.items():
        exec_test_i(dirname, target, admonition)

    for target in targets:
        res = subprocess.run(["cmake", '--build', dirname + '.admonition', '--target', target],
                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if os.name == 'nt':
            res.stderr = res.stdout # on nt, stderr seems to be always empty

        if res.returncode != 0:
            print('test "%s" failed' % target, file=sys.stderr)
            print(res.stderr.decode('utf-8'), file=sys.stderr)
        else:
            print('test "%s" passed' % target)

if __name__ == "__main__":

    target_admonition_gcc = {
        'local_adress':'-Werror=return-local-addr',
        'sign_conversion':'-Wsign-conversion',
        'return_type':'-Werror=return-type',
        'format':'-Werror=format',
        'throw_spec':'-Wdeprecated',
        #'nullptr':'-Wzero-as-null-pointer-constant', # does no behave as expected on gcc
        }

    targets_gcc = ['debug_iterator']

    dirname_gcc = 'build.gcc'

    env_with_gcc = os.environ
    env_with_gcc['CC'] = '/usr/bin/gcc'
    env_with_gcc['CXX'] = '/usr/bin/g++'

    if os.name != 'nt':
        exec_test(dirname_gcc, env_with_gcc, target_admonition_gcc, targets_gcc)

    target_admonition_clang = {
        'local_adress':'-Werror,-Wreturn-stack-address',
        'sign_conversion':'-Wsign-conversion',
        'return_type':'-Werror,-Wreturn-type',
        'format':'-Werror,-Wformat',
        'throw_spec':'-Wdeprecated-dynamic-exception-spec',
        'nullptr':'-Wzero-as-null-pointer-constant',
        }
    targets_clang = ['debug_iterator']

    dirname_clang = 'build.clang'

    env_with_clang = os.environ
    env_with_clang['CC'] = '/usr/bin/clang'
    env_with_clang['CXX'] = '/usr/bin/clang++'

    if os.name != 'nt':
        exec_test(dirname_clang, env_with_clang, target_admonition_clang, targets_clang)

    target_admonition_msvc = {
        'local_adress':'warning C4172',
        'sign_conversion':'warning C4365',
        #'return_type':'error C4716', # does not compile by default
        'format':'error C4477',
        'throw_spec':'warning C4290',
        #'nullptr':'warning C26477', # no warning or error
        }

    dirname_msvc = 'build.msvc'
    targets_msvc = ['debug_iterator']

    env_with_msvc = os.environ
    #env_with_msvc['CC'] = '/usr/bin/clang'
    #env_with_msvc['CXX'] = '/usr/bin/clang++'
    if os.name == 'nt':
        exec_test(dirname_msvc, env_with_msvc, target_admonition_msvc, targets_msvc)
