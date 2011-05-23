accumulators
============

A set of statistical accumulators for Ruby. There is a range of containers for
different measures, such as count, mean, and mean-variance. You can add values to
the containers, and ask for their respective statistical measures. 

Where appropriate the accumulators use incremental algorithms to update their
measures with each addition, so you can add lots of values without needing lots of
memory. (see http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#On-line_algorithm)

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

Available accumulators
----------------------

* Count
* Mean
* MeanVariance

TODO
----

* Skew?
* Weighted Means
* min, max, and min-max
* sum

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

