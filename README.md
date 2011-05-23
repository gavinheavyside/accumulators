accumulators
============

A set of statistical accumulators for Ruby. There is a range of containers for
different measures, such as count, sum, mean, and mean-variance. You can add values to
the containers, and ask for their respective statistical measures. 

Where appropriate the accumulators use incremental algorithms to update their
measures with each addition, so you can add lots of values without needing lots of
memory. (see http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#On-line_algorithm)

The accumulators can be combined. e.g. if you have two mean-variance
accumulators, each of which has their own mean and variance, you can add them
together to get the mean and variance of the combined samples.

Always remember that floating-point arithmetic is not precise, so if you are
using these accumulators for anything important, and especially if you are
accumulating lots of samples, you should run your own tests on the accuracy of
the calculations. I am not aware of any significant issues, but I make no promises
and provide no assurances as to the accuracy or stability of these
calculations.

Installation
------------
    $ [sudo] gem install accumulators

Example Usage
-------------

    $ irb
    >> require 'accumulators'
    >> meanvar = Accumulators:MeanVariance.new
    >> meanvar.add 1
    >> meanvar.add 2
    >> meanvar.add 3
    >> meanvar.add 4
    >> meanvar.count
    => 4
    >> meanvar.mean
    => 2.5
    >> meanvar.variance
    => 1.0
    >> meanvar.variance(type: :sample)
    => 1.0
    >> meanvar.variance(type: :population)
    => 1.25
    >> meanvar.stddev
    => 1.0
    >> meanvar.stddev(type: :population)
    => 1.118033988749895

Example of combining accumulators
---------------------------------
Accumulators of the same type can be added together. Here we will add three
numbers to one mean-variance accumulator, three to another, and show that their
combined mean and variance is equal to that of the single accumulator which
saw all the values, within the usual constraints of floating-point arithmetic.

    >> mv1 = Accumulators::MeanVariance.new  # sees the first 3 values
    >> mv2 = Accumulators::MeanVariance.new  # sees the second 3 values
    >> mv  = Accumulators::MeanVariance.new  # sees all values
    >>
    >> [1.1, 2.2, 3.3].each {|n| mv1.add n; mv.add n}
    >> [4.4, 5.5, 6.6].each {|n| mv2.add n; mv.add n}
    >>
    >> mv1.mean
    => 2.2
    >> mv1.variance
    => 0.6049999999999998
    >>
    >> mv2.mean
    => 5.5
    >> mv2.variance
    => 0.6049999999999998
    >>
    >> mv.mean
    => 3.8499999999999996
    >> mv.variance
    => 3.025
    >>
    >> mv1.add mv2
    >> mv1.mean
    => 3.8499999999999996
    >> mv1.variance
    >> 3.0249999999999995  # close to 3.025 - discrepancy from floating-point

Available accumulators
----------------------

* Count
* Sum
* MinMax
* Mean
* MeanVariance

TODO
----

* Skew?
* Weighted Means

Contributing to accumulators
----------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2010-2011 Gavin Heavyside. See LICENSE.txt for
further details.

