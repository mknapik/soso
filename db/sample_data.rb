# Populate the database with a small set of realistic sample data so that as a developer/designer, you can use the
# application without having to create a bunch of stuff or pull down production data.
#
# After running db:sample_data, a developer/designer should be able to fire up the app, sign in, browse data and see
# examples of practically anything (interesting) that can happen in the system.
#
# It'sector_name a good idea to build this up along with the features; when you build a feature, make sure you can easily demo it
# after running db:sample_data.
#
# Data that is required by the application across all environments (i.e. reference data) should _not_ be included here.
# That belongs in seeds.rb instead.

# TODO Disable sending emails, no need for seed data.

[:superadmin, :admin, :manager, :staff, :user].each.with_index do |role, index|
  Role.where(id: index+1, name: role).first_or_create!
end

poland = Country.where(code: 'PL', name: 'Poland').first_or_create!
krakow = City.where(name: 'Kraków', country_id: poland.id).first_or_create!
warszawa = City.where(name: 'Warszawa', country_id: poland.id).first_or_create!
agh = Committee.where(name: 'AGH', city_id: krakow.id).first_or_create!
uw = Committee.where(name: 'UW', city_id: warszawa.id).first_or_create!

users = []

users << User.where(email: 'admin@example.com', name: 'admin', surname: 'admin', role_id: Role.admin).first_or_initialize
users << User.where(email: 'mike@example.com', name: 'Mike', surname: 'Smith').first_or_initialize

users.each do |user|
  user.password = 'password'
  user.committee = agh
  user.student_no = 1000+rand(100)
  user.confirmed_at = Time.now
  user.save!
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


###
faculties = {'Wydział Elektrotechniki, Automatyki i Inżynierii Biomedycznej' =>
                 {'Automatyka i Robotyka' => ['-', 'Neurocybernetyka'],
                  'Elektrotechnika' =>
                      ['Elektroenergetyka',
                       'Automatyka Przemysłowa i Automatyka Budynków',
                       'Automatyka i Metrologia'],
                  'Informatyka Stosowana' => [],
                 },
             'Wydział Energetyki i Paliw' =>
                 {'Energetyka' =>
                      [
                       'Systemy maszyny i urządzenia energetyczne',
                       'Energetyka Jądrowa'],
                  'Technologia chemiczna' =>
                      ['Zgazowanie i Odgazowanie Paliw Stałych',
                       'Sustainable Fuel Economy',
                       'Technologia Paliw']},
             'Wydział Inżynierii Mechanicznej I Robotyki' =>
                 {'Mechanika i Budowa Maszyn' =>
                      ['Eksploatacja I Technologia Maszyn i Pojazdów',
                       'Inżynieria Systemów Wytwarzania',
                       'Maszyny do Robót Ziemnych i Transportu Bliskiego'],
                  'Inżynieria Akustyczna' =>
                      ['Inżynieria dźwięku w mediach i kulturze', 'Wibroakustyka'],
                  'Automatyka i Robotyka' =>
                      ['Automatyzacja w Systemach Transportowych',
                       '-',
                       'Robotyka',
                       'Automatyka i metrologia'],
                  'Mechatronika' =>
                      ['Wytwarzanie Mechatroniczne',
                       'Systemy Inteligentne',
                       'Projektowanie Mechatroniczne']
                 },
             'Wydział Metali Nieżelaznych' =>
                 {'Metalurgia' =>
                      ['Metalurgia', 'Przeróbka Plastyczna', 'Recykling i ochrona środowiska'],
                  'Zarządzanie i Inżynieria Produkcji' =>
                      ['Inżynieria produkcji i zastosowanie metali nieżelaznych'],
                  'Inżynieria Materiałowa' => ['inżynieria materiałów metalicznych']
                 },
             'Wydział Zarządzania' =>
                 {'Zarządzanie' =>
                      ['Marketing',
                       'Zarządzanie finansami',
                       'Zarządzanie systemami produkcyjnymi',
                       'Finanse'],
                  'Zarządzanie i Inżynieria Produkcji' =>
                      ['Zarządzanie logistyczne', 'Zarządzanie Produkcją']
                 },
             'Wydział Geodezji Górniczej I Inżynierii Środowiska' =>
                 {'Geodezja i Kartografia' =>
                      ['Gospodarka nieruchomościami i kataster',
                       'Geoinformatyka, fotogrametria i teledetekcja',
                       'Geomatyka',
                       'Geodezja Inżynieryjno przemysłowa',

                       'Geodezja Inżynieryjno Przemysłowa'],
                  'Inżynieria Środowiska' => ['Inżynieria komunalna']
                 },
             'Wydział Matematyki Stosowanej' =>
                 {'Matematyka Stosowana' =>
                      ['matematyka finansowa i ubezpieczeniowa', 'Matematyka Finansowa'],
                  'Matematyka' =>
                      ['Matematyka w informatyce',
                       'matematyka finansowa i ubezpieczeniowa',
                       'Matematyka finansowa',
                       'Matematyka w Naukach Technicznych i Przyrodniczych',
                       'Komputerowo Obliczeniowa',
                       'matematyka w informatyce i zarządzaniu']
                 },
             'Wydział Informatyki, Elektroniki i Telekomunikacji' =>
                 {'Elektronika i Telekomunikacja' => ['Telekomunikacja', 'Elektronika', 'e'],
                  'Informatyka' => ['Wytwarzanie i integracja systemów informatycznych']
                 },
             'Wydział Geologii, Geofizyki I Ochrony Środowiska' =>
                 {'Geofizyka' => ['Geofizyka', 'Geofizyka ', 'Geofizyka poszukiwawcza', '-'],
                  'Górnictwo i Geologia' =>
                      ['Hydrogeologia i Geologia Inżynierska',
                       'Geologia naftowa',
                       'Geologia Górnicza',
                       'Geologia i Prospekcja Złóż'],
                  'Inżynieria Środowiska' =>
                      ['hydrogeologia i geologia inżynierska',
                       'nie istnieje',
                       'Odnawialne Źródła Energii',
                       'Inżynieria Mineralna'],
                  'Ochrona Środowiska' => ['brak']
                 },
             'Geologii,Geofizyki i Ochrony Środowiska' =>
                 {'Górnictwo i Geologia, Inżynieria Środowiska' =>
                      ['Odnawialne źródła energii']
                 },
             'EAIiB' => {'Informatyka Stosowana' => ['Nowoczesna Grafika Komputerowa']
             },
             'Wydział Inżynierii Metali i Informatyki Przemysłowej' =>
                 {'Inżynieria Materiałowa' =>
                      ['Inżynieria Powierzchni',
                       'Przetwórstwo Metali i Stopów Specjalnych',
                       'Przetwórstwo Stopów i Materiałów Specjalnych',
                       'inzynieria spajania',
                       'Inżynieria Stali i Stopów Specjalnych'],
                  'Informatyka Stosowana' => ['Modelowanie i Technologie Informacyjne'],
                  'Metalurgia' => ['Przeróbka Plastyczna', 'Technika cieplna']
                 },
             'Wydział Górnictwa i Geoinżynierii' =>
                 {'Inżynieria Środowiska' =>
                      ['Zagospodarowanie Surowców i Odpadów',
                       'Inżynieria Ochrony Środowiska',
                       'Wentylacja i Klimatyzacja Przemysłowa'],
                  'Budownictwo' =>
                      ['Rewaloryzacja zabytków / Budownictwo Specjalne',
                       'Geotechnika i budownictwo specjalne'],
                  'Górnictwo i Geologia' =>
                      ['Inżynieria mechaniczna i elektryczna w górnictwie',
                       'Eksploatacja złóż surowców mineralnych',
                       'Przeróbka kopalin, obróbka kamienia, ochrona środowiska',
                       'Górnictwo odkrywkowe'],
                  'Zarządzanie i Inżynieria Produkcji' =>
                      ['Zarządzanie Przedsiębiorstwem Przemysłowym',
                       'Zarządzanie w Inżynierii Środowiska']
                 },
             'Wydział Fizyki I Informatyki Stosowanej' =>
                 {'Fizyka Techniczna' => ['Fizyka Komputerowa', 'Fizyka Jądrowa'],
                  'Fizyka Medyczna' =>
                      ['nie istnieje',
                       'Dozymetria i Elektronika w Medycynie',
                       'Techniki Obrazowania i Biometria']
                 },
             'Wydział Inżynierii Materiałowej I Ceramiki' =>
                 {'Ceramika' =>
                      ['Ceramika Techniczna i Konstrukcyjna',
                       'Materiały do konserwacji i rewitalizacji'],
                  'Inżynieria Materiałowa' =>
                      ['Functional Materials',
                       'Biomateriały i Nanokompozyty',
                       'Materiały Funkcjonalne'],
                  'Technologia Chemiczna' =>
                      ['Analityka i Kontrola Jakości',
                       'Technologia Ceramiki i Materiałów Ogniotrwałych',
                       'Technologia Materiałów Budowlanych'],
                  'Ceramika Specjalna i Ogniotrwała' => ['Ceramika Specjalna']
                 },
             'GiG' =>
                 {'ZIP' => ['ZPP'],
                  'Zarządzanie i Inżynieria Produkcji' =>
                      ['zarządzanie przedsiębiorstwem przemysłowym']
                 },
             'Zarządzania' => {'Zarządzanie' => ['Zarządzanie Finansami']
             },
             'IMIR' =>
                 {'Mechatronika' => ['Systemy inteligentne'],
                  'Mechanika i Budowa Maszyn' => ['Informatyka w Inżynierii Mechanicznej']
                 },
             'WEIP' => {'Energetyka' => ['Energetyka']
             },
             'Wydział Wiertnictwa, Nafty I Gazu' =>
                 {'Górnictwo i Geologia' => ['Wiertnictwo i Geoinżynieria'],
                  'Inżynieria Naftowa i Gazownicza' => ['-', 'brak']
                 },
             'Wydział Zarządzania, Wydział Elektrotechniki, Automatyki i Inżynierii Biomedycznej' =>
                 {'Zarządzanie i Inżynieria Produkcji, Inżynieria Biomedyczna' =>
                      ['Zarządzanie logistyczne, Informtyka i Elektronika medyczna']
                 },
             'WIMIR' =>
                 {'automatyka i robotyka' => ['-'],
                  'Inżynieria Akustyczna' => ['Wibroakustyka'],
                  'Mechatronika' => ['Projektowanie Mechatroniczne']
                 },
             'ekonomiczno-socjologiczny UŁ' => {'ekonomia' => ['inwestycje i nieruchomości']
             },
             'Wydział Inżynierii Mechanicznej I Robotykim' =>
                 {'Mechanika i Budowa Maszyn' =>
                      ['Maszyny do przeróki i eksploatacji surowców mineralnych']
                 },
             'WGGiOŚ/WGiG' => {'IŚ/ZiIP' => ['Nie istnieje']
             },
             'Międzywydziałowa Szkoła Inżynierii Biomedycznej' =>
                 {'Inżynieria Biomedycza' => ['Elektronika i Informatyka Medyczna']
                 },
             'GGiOŚ' => {'Górnictwo i Geologia' => ['Geologia Inżynierska']}}

faculties.each do |faculty_name, field_of_studies|
  faculty = Faculty.where(name: faculty_name, committee_id: agh.id).first_or_create!
  field_of_studies.each do |field_of_study_name, specializations|
    field_of_study = FieldOfStudy.where(name: field_of_study_name, faculty_id: faculty.id).first_or_create!
    specializations.each do |specialization_name|
      specialization = Specialization.where(name: specialization_name, field_of_study_id: field_of_study.id).first_or_create!
      puts specialization.inspect
    end
  end
end