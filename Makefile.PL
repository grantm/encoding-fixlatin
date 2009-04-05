use inc::Module::Install;

name     'Encoding-FixLatin';
all_from 'lib/Encoding/FixLatin.pm';
author   'Grant McLean <grantm@cpan.org>';

test_requires 'Test::More' => '0.45';

auto_install;

install_script 'fix_latin';

WriteAll;

