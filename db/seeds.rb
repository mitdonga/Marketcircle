# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

data = [
    {
        "name": "Tara McKenzie",
        "info": {
            "title": "Dr.",
            "age": 42,
            "phone": "(674) 936-7086 x45855",
            "email": "skoch@gmail.com"
        }
    },
    {
        "name": "Janae Price",
        "info": {
            "title": "Ms.",
            "age": 53,
            "phone": "312.465.6125 x301",
            "email": "spollich@gmail.com"
        }
    },
    {
        "name": "Christiana Torphy",
        "info": {
            "title": "Prof.",
            "age": 43,
            "phone": "870-447-4548 x35589",
            "email": "damien.koss@yahoo.com"
        }
    },
    {
        "name": "Robyn Huels",
        "info": {
            "title": "Dr.",
            "age": 32,
            "phone": "(657) 879-4130",
            "email": "dcollier@gmail.com"
        }
    },
    {
        "name": "Brad Bauch",
        "info": {
            "title": "Dr.",
            "age": 47,
            "phone": "(902) 597-6407",
            "email": "bernhard.kamron@yahoo.com"
        }
    },
    {
        "name": "Dax Walker",
        "info": {
            "title": "Mrs.",
            "age": 54,
            "phone": "1-530-991-0017 x3164",
            "email": "temard@gmail.com"
        }
    },
    {
        "name": "Lyla Bode",
        "info": {
            "title": "Prof.",
            "age": 39,
            "phone": "310.294.7075",
            "email": "briana.fay@gmail.com"
        }
    },
    {
        "name": "Dayne Leffler",
        "info": {
            "title": "Mr.",
            "age": 20,
            "phone": "663.218.8949 x1039",
            "email": "upollich@hotmail.com"
        }
    },
    {
        "name": "Savannah Marks",
        "info": {
            "title": "Prof.",
            "age": 40,
            "phone": "+1 (918) 479-3516",
            "email": "deanna71@yahoo.com"
        }
    },
    {
        "name": "Mazie Kerluke",
        "info": {
            "title": "Prof.",
            "age": 36,
            "phone": "717.714.4363 x878",
            "email": "nkerluke@yahoo.com"
        }
    }
]

data.each do |user_data|
  user = User.find_or_create_by(name: user_data[:name])
  info = user_data[:info]
  Info.find_or_create_by(user: user, title: info[:title], age: info[:age], phone: info[:phone], email: info[:email])
end