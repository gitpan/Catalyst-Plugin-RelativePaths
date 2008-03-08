use inc::Module::Install;

name     'Catalyst-Plugin-RelativePaths';
all_from 'lib/Catalyst/Plugin/RelativePaths.pm';
author   'Rafael Kitover <rkitover@cpan.org>';

requires 'Catalyst' => '5.7007';
requires 'Class::C3';

build_requires 'Test::More';

auto_install;

WriteAll;
