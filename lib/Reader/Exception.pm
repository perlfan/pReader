package Reader::Exception;

{

    package Reader::Exception::Base;

    use Moose;
    use namespace::clean -except => 'meta';

    with 'Reader::Exception::Basic';

    __PACKAGE__->meta->make_immutable;
}

{

    package Reader::Exception;

    use Moose;
    use namespace::clean -except => 'meta';

    BEGIN {
        extends 'Reader::Exception::Base';
    }

    __PACKAGE__->meta->make_immutable;
}

1;

__END__
