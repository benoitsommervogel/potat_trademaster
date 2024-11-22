# ./lib/tasks/fill_table.rake
namespace :custom_task do
    desc "Fill the Rate table with interesting data for the past 3 days"
    task :initialize_rates do
        Rate.all.destroy_all
        ((Time.now-2.days).to_i..Time.now.to_i).step(10.minutes).each{ |time|
            Rate.create(time: Time.at(time), value: rand(100.10..150.10).truncate(2))
        }
    end
end