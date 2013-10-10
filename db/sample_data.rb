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


pol = Language.where(iso_code: 'pol', name: 'Polish').first_or_create!
eng = Language.where(iso_code: 'eng', name: 'English').first_or_create!
deu = Language.where(iso_code: 'deu', name: 'German').first_or_create!

poland = Country.where(code: 'PL', language: pol, name: 'Poland').first_or_create!
krakow = City.where(name: 'Kraków', country_id: poland.id).first_or_create!
warszawa = City.where(name: 'Warszawa', country_id: poland.id).first_or_create!
agh = Committee.where(name: 'AGH', city_id: krakow.id).first_or_create!
uw = Committee.where(name: 'UW', city_id: warszawa.id).first_or_create!

[eng, deu].each do |language|
  agh.languages << language unless language.in? agh.languages
  (41..43).each do |n|
    Exam.where(language: language, committee: agh, state: :open, min: 5, max: 15, datetime: n.days.since(Time.now)).first_or_create!
  end
end

users = []

users << User.where(email: 'admin@example.com', name: 'admin', surname: 'admin', role: Role.admin).first_or_initialize
users << User.where(email: 'mike@example.com', name: 'Mike', surname: 'Smith').first_or_initialize

users.each do |user|
  user.password = 'password'
  user.committee = agh
  user.student_no = 1000+rand(100)
  user.confirmed_at = Time.now
  user.save!
end

###
faculties = {'Wydział Elektrotechniki, Automatyki i Inżynierii Biomedycznej' =>
                 {'Automatyka i Robotyka' => ['-', 'Neurocybernetyka'],
                  'Elektrotechnika' =>
                      ['Elektroenergetyka',
                       'Automatyka Przemysłowa i Automatyka Budynków',
                       'Automatyka i Metrologia'],
                  'Informatyka Stosowana' => ['Nowoczesna Grafika Komputerowa'],
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
                       'Mechanika i Budowa Maszyn',
                       'Projektowanie Mechatroniczne',
                       'Informatyka w Inżynierii Mechanicznej']
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
             'Wydział Wiertnictwa, Nafty I Gazu' =>
                 {'Górnictwo i Geologia' => ['Wiertnictwo i Geoinżynieria'],
                  'Inżynieria Naftowa i Gazownicza' => ['-', 'brak']
                 },
             'Wydział Zarządzania, Wydział Elektrotechniki, Automatyki i Inżynierii Biomedycznej' =>
                 {'Zarządzanie i Inżynieria Produkcji, Inżynieria Biomedyczna' =>
                      ['Zarządzanie logistyczne, Informtyka i Elektronika medyczna']
                 },
             'Wydział Inżynierii Mechanicznej I Robotykim' =>
                 {'Mechanika i Budowa Maszyn' =>
                      ['Maszyny do przeróki i eksploatacji surowców mineralnych']
                 },
             'Międzywydziałowa Szkoła Inżynierii Biomedycznej' =>
                 {'Inżynieria Biomedycza' => ['Elektronika i Informatyka Medyczna']
                 }
             }
faculties.each do |faculty_name, field_of_studies|
  faculty = Faculty.where(name: faculty_name, committee_id: agh.id).first_or_create!
  field_of_studies.each do |field_of_study_name, specializations|
    field_of_study = FieldOfStudy.where(name: field_of_study_name, faculty_id: faculty.id).first_or_create!
    specializations.each do |specialization_name|
      specialization = Specialization.where(name: specialization_name, field_of_study_id: field_of_study.id).first_or_create!
    end
  end
end if Faculty.count == 0

about_page = Page.where(slug: 'site', title: 'Site').first_or_initialize
about_page.content = '<b>strongly</b> static web page with <pre>html</pre> features'
about_page.save


contact_page = Page.where(slug: 'contact', title: 'Contact').first_or_initialize
contact_page.content = <<EOS
<div class='row'>
  <div class='span4'>
    <h4>IO</h4>
  </div>
  <div class='offset2 span4'>
    <h4>IT</h4>
  </div>
</div>
EOS
contact_page.save

Page.where(slug: 'in-the-pill', title: 'In the pill', content: '').first_or_create!
Page.where(slug: 'terms', title: 'Terms of participation', content: '').first_or_create!

['Mathematics', 'Physics', 'Mechanics'].each do |name|
  Subject.where(name: name, committee_id: agh.id).first_or_create!
end

load './db/fixtures/subjects.rb'
init_subjects(agh.id)
load './db/fixtures/faqs.rb'
init_faqs(agh.id)

