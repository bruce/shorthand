Shorthand
=========

Shorthand gives you an easy way to add a object-focused DSL (an OSL,
if you will) useful for configuring instances -- without dirtying up
your class implementation.  This of it as running your DSL in a little
sandbox.

For example, let's say we have a class, Person:

    class Person
      # with a lot of accessors
    end

And we'd like an API like:

    Person.new do
      name 'Bruce Williams'
      location 'Portland, OR'
    end

Provided we had `name=` and `location=` attribute writers defined on
`Person`, this would be as easy as:

    class Person
      include Shorthand # this line
    end

If you prefer yield-style semantics, rest assured this API would work
as well:

    Person.new do |person|
      person.name 'Bruce Williams'
      person.location 'Portland, OR'
    end

You can also use the `shorthand` method after initialization:

    person = Person.new('Bruce', 'Williams')
    person.shorthand do
      location 'Portland, OR'
      zipcode '97209'
    end

Want to one use one or the other?  You can include the ala-carte
modules `Shorthand::Init` or `Shorthand::Method` instead.

Want to give the `shorthand` method another name (like `configure`)?
Have at it with `alias` and `alias_method`.

Copyright
---------

Copyright (c) 2010 Bruce Williams. See LICENSE for details.


