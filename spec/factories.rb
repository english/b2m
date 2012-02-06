FactoryGirl.define do
  #factory :config, :class => B2m::Config do
    #ignore do
      #json Hash.new.merge({
        #'required-headers' => %w{ condition _store qty },
        #'defaults'  => { 'condition' => 'new', 'gender' => 'ladies' },
        #'categories' => {
            #1 => 'Rings',
            #2 => 'Charms',
            #4 => 'Neckwear',
            #5 => 'Wristwear',
            #6 => 'Earrings',
            #8 => 'Other',
            #9 => 'Watches' },
        #'department-defaults' => {
          #'01' => {
            #'00' => { 'material' => 'gold' },
            #'01' => { 'material' => 'gold' } },
          #'02' => {
            #'00' => { 'material' => 'silver' } },
          #'03,04' => {
            #'00' => { 'material' => 'steel' },
            #'01,02' => { 'material' => 'rose gold' }
          #}
        #}
      #})
    #end

    #initialize_with { B2m::Config.new(json) }
  #end
end
