use ExtUtils::MakeMaker;

require 5.005;

WriteMakefile(
    'NAME'         => 'Config::Simple',
    'VERSION_FROM' => 'lib/Config/Simple.pm', 
    'ABSTRACT_FROM'=> 'lib/Config/Simple.pm',
    'PREREQ_PM'    => {
#       'AutoLoader'       => 0,
        'Carp'             => 0,
        'Fcntl'            => 0,
        'File::Spec'       => 0,
        'FindBin'          => 0,
        'Text::ParseWords' => 0,
    },
    'BUILD_REQUIRES' => {
        'Test'         => 0,
        'Test::More'   => 0,
    },
    AUTHOR => 'Sherzod B. Ruzmetov <sherzodr@cpan.org>'
);
