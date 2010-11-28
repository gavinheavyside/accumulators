accumulators
============

A set of statistical accumulators for Ruby. There is a range of containers for
different measures, such as count, mean, and mean-variance. You can add values to
the containers, and ask for their respective statistical measures. The accumulators
use incremental algorithms to update their measures with each addition, so you can
add lots of values without needing lots of memory.

Installation
------------
    $ [sudo] gem install accumulators

Example Usage
-------------

    $ irb
    >> require 'accumulators'
    >> mean = Accumulators::Mean.new
    >> mean.add 1
    >> mean.add 2
    >> mean.add 3
    >> mean.add 4
    >> mean.count
    => 4
    >> mean.mean
    => 2.5

Available accumulators
----------------------

* Count
* Mean
* MeanVariance

TODO
----

* Allow choosing between biased & unbiased variance/standard devation
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

Copyright (c) 2010 Gavin Heavyside. See LICENSE.txt for
further details.

