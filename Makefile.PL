use 5.016003;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Acme::Snap',
    VERSION_FROM      => 'lib/Acme/Snap.pm', # finds $VERSION
    PREREQ_PM         => { Badger => 0.09 },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Acme/Snap.pm', # retrieve abstract from module
       AUTHOR         => 'Andy Wardley <abw@wardley.org>') : ()),
);
