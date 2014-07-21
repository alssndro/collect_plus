# collect_plus

A simple gem to retrieve the status of parcels sent via [CollectPlus](http://collectplus.co.uk).

## Installation

Add this line to your application's Gemfile:

    gem 'collect_plus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install collect_plus

## Usage

``` ruby
# Initialise a new CollectPlus::Tracker by passing in the tracking number
tracker = CollectPlus::Tracker.new("ABC123")

# Get the current tracking status
tracker.current_status
=> "Despatched from LONDON DEPOT - 15:58, Mon, 07 Jul 2014"

# Get previous tracking statuses
# Returns an array of status strings
tracker.status_history
=> ["Loaded onto VAN - 06:35, Wed, 09 Jul 2014", 
"Processed at National Hub - 11:45, Tue, 08 Jul 2014", 
"Processed at National Hub - 11:39, Tue, 08 Jul 2014", 
"Despatched from LONDON DEPOT - 15:58, Mon, 07 Jul 2014", 
"Parcel collected - 11:46, Mon, 07 Jul 2014", 
"Received at SPAR, LDN - 08:21, Mon, 07 Jul 2014", 
"Delivery booked - 13:25, Sun, 06 Jul 2014"]

# Get a print-friendly summary of all tracking statues so far
puts tracker.status_summary
=> CURRENT STATUS
Loaded onto VAN - 06:35, Wed, 09 Jul 2014

STATUS HISTORY
Processed at National Hub - 11:45, Tue, 08 Jul 2014

Processed at National Hub - 11:39, Tue, 08 Jul 2014

Despatched from LONDON DEPOT - 15:58, Mon, 07 Jul 2014

Parcel collected - 11:46, Mon, 07 Jul 2014

Received at SPAR, LDN - 08:21, Mon, 07 Jul 2014

Delivery booked - 13:25, Sun, 06 Jul 2014

# Update tracking info
tracker.track
tracker.current_status
=> "Delivered to Customer at 11:14, Wed, 09 Jul 2014"
```

