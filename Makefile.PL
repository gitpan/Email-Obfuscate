use inc::Module::Install;

name('Email-Obfuscate');
version_from('lib/Email/Obfuscate.pm');
abstract('Obfuscates email addresses');
author('Adam J. Foxson <afoxson@pobox.com>');
license('gpl');
include('ExtUtils::AutoInstall');
check_nmake();
auto_install();

&Meta->write;
&Build->write if lc($0) eq 'build.pl';
&Makefile->write if lc($0) eq 'makefile.pl';
