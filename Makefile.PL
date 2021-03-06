# -*- mode: perl; c-basic-offset: 4; indent-tabs-mode: nil; -*-
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile1(
    'NAME'          => 'AI::MegaHAL',
    'VERSION_FROM'  => 'lib/AI/MegaHAL.pm',
    ABSTRACT_FROM => 'lib/AI/MegaHAL.pm',
    AUTHOR => 'Alexandr Ciornii <alexchorny@gmail.com>',
    'LICENSE' => 'gpl',
    'OBJECT' => 'MegaHAL.o libmegahal.o',
    PREREQ_PM    => {
    },
    TEST_REQUIRES    => {
        'Test::More'      => '0.47',
    },
    META_MERGE => {
        resources => {
            repository => 'http://github.com/chorny/AI-MegaHAL',
            keywords => ['megahal','chat',],
        },
    },
    MIN_PERL_VERSION  => '5.005',
    $^O =~/win/i ? (
        dist => {
            TAR      => 'ptar',
            TARFLAGS => '-c -C -f',
        },
    ) : (),
	(-d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING} || $ENV{TRAVIS}) ? (
		test => {
			TESTS => 't/*.t xt/*.t',
		},
	) : (),
);


sub WriteMakefile1 {  #Compatibility code for old versions of EU::MM. Written by Alexandr Ciornii, version 2. Added by eumm-upgrade.
    my %params=@_;
    my $eumm_version=$ExtUtils::MakeMaker::VERSION;
    $eumm_version=eval $eumm_version;
    die "EXTRA_META is deprecated" if exists $params{EXTRA_META};
    die "License not specified" if not exists $params{LICENSE};
    if ($params{AUTHOR} and ref($params{AUTHOR}) eq 'ARRAY' and $eumm_version < 6.5705) {
        $params{META_ADD}->{author}=$params{AUTHOR};
        $params{AUTHOR}=join(', ',@{$params{AUTHOR}});
    }
    if ($params{TEST_REQUIRES} and $eumm_version < 6.64) {
        $params{BUILD_REQUIRES}={ %{$params{BUILD_REQUIRES} || {}} , %{$params{TEST_REQUIRES}} };
        delete $params{TEST_REQUIRES};
    }
    if ($params{BUILD_REQUIRES} and $eumm_version < 6.5503) {
        #EUMM 6.5502 has problems with BUILD_REQUIRES
        $params{PREREQ_PM}={ %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}} };
        delete $params{BUILD_REQUIRES};
    }
    delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
    delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
    delete $params{META_MERGE} if $eumm_version < 6.46;
    delete $params{META_ADD} if $eumm_version < 6.46;
    delete $params{LICENSE} if $eumm_version < 6.31;

    WriteMakefile(%params);
}

