use inc::Module::Install;

name     'Text-Phonetic-VideoGame';
all_from 'lib/Text/Phonetic/VideoGame.pm';
author   'Michael Hendricks <michael@ndrix.org>';
license  'mit';

build_requires 'Test::More';

auto_install;

WriteAll;

