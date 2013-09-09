# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[:superadmin, :admin, :manager, :staff, :user].each.with_index do |role, index|
  Role.where(id: index+1, name: role).first_or_create!
end

{
    'Engineering & Technology' =>
        ['Areonautical Engineering', 'Bioengineering', 'Biotechnology', 'Chemical Engineering', 'Civil Eng.',
         'Computer Science', 'Electrical Engineering', 'Electronics', 'Environmental Eng.', 'Food Technology',
         'Geodesy', 'Industrial Eng.', 'Mechanical Eng.', 'Mechatronics', 'Metallurgy', 'Mining', 'Naval Engineering',
         'Petroleum Engineering', 'Telecommunications', 'Textile Technology', 'Wood & Paper Tech.', 'Automatics'],
    'Applied Arts' => ['Architecture', 'Architecture Studies', 'Architectural Studies', 'Media Studies'],
    'Sciences' => ['Wood & Paper Technology', 'Biochemistry', 'Biology', 'Chemistry', 'Geography', 'Geology',
                   'Material Science', 'Mathematics', 'Microbiology', 'Pharmaceutical Studies', 'Physics',
                   'Veterinary Science', 'Geophysics'],
    'Agriculture' => ['Agriculture'],
    'Others' => ['Commerce', 'Economics', 'Hotel & Management', 'Languages']
}.each do |sector_group_name, sectors|
  sector_group = SectorGroup.where(name: sector_group_name).first_or_create!
  sectors.each do |sector_name|
    Sector.where(name: sector_name, sector_group_id: sector_group.id).first_or_create!
  end
end
