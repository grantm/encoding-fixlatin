use inc::Module::Install;

name     'Encoding-FixLatin';
all_from 'lib/Encoding/FixLatin.pm';
author   'Grant McLean <grantm@cpan.org>';
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

