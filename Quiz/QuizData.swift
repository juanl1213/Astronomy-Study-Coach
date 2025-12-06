//
//  QuizData.swift
//  Astronomy Study Coach
//
//  Quiz questions for all astronomy topics
//

import SwiftUI

struct QuizData: Identifiable {
    let id: String
    let title: String
    let description: String
    let questions: Int
    let difficulty: String
    let timeEstimate: String
    let category: String
}

struct QuizQuestion {
    let id: Int
    let question: String
    let options: [String]
    let correctAnswer: Int
    let explanation: String
    let topic: String
}

struct QuizQuestions {
    static let allQuizzes: [String: [QuizQuestion]] = [
        "solar-system": solarSystemQuestions,
        "planets": planetsQuestions,
        "stars": starsQuestions,
        "galaxies": galaxiesQuestions,
        "cosmology": cosmologyQuestions,
        "exoplanets": exoplanetsQuestions,
        "black-holes": blackHolesQuestions,
        "nebulae": nebulaeQuestions,
        "asteroids": asteroidsQuestions,
        "space-exploration": spaceExplorationQuestions
    ]
    
    // Solar System Questions
    static let solarSystemQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What is the approximate age of our Solar System?",
            options: [
                "2.5 billion years",
                "4.6 billion years",
                "6.8 billion years",
                "10 billion years"
            ],
            correctAnswer: 1,
            explanation: "Our Solar System formed approximately 4.6 billion years ago from the gravitational collapse of a giant molecular cloud.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 2,
            question: "Which object contains 99.86% of the Solar System's mass?",
            options: [
                "Jupiter",
                "The Sun",
                "All planets combined",
                "Asteroids and comets"
            ],
            correctAnswer: 1,
            explanation: "The Sun contains 99.86% of the Solar System's total mass. All planets, moons, asteroids, and comets make up only 0.14%.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 3,
            question: "What are the four inner planets called?",
            options: [
                "Gas giants",
                "Terrestrial planets",
                "Ice giants",
                "Dwarf planets"
            ],
            correctAnswer: 1,
            explanation: "The four inner planets (Mercury, Venus, Earth, and Mars) are called terrestrial planets because they have solid, rocky surfaces.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 4,
            question: "What is an Astronomical Unit (AU)?",
            options: [
                "The distance from Earth to the Moon",
                "The average distance from Earth to the Sun",
                "The diameter of the Sun",
                "The distance light travels in one year"
            ],
            correctAnswer: 1,
            explanation: "An Astronomical Unit (AU) is the average distance from Earth to the Sun, approximately 150 million kilometers (93 million miles).",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 5,
            question: "Where is the asteroid belt located?",
            options: [
                "Between Earth and Mars",
                "Between Mars and Jupiter",
                "Between Jupiter and Saturn",
                "Beyond Neptune"
            ],
            correctAnswer: 1,
            explanation: "The main asteroid belt is located between the orbits of Mars and Jupiter, containing millions of rocky objects.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 6,
            question: "What is the Kuiper Belt?",
            options: [
                "A region of asteroids between Mars and Jupiter",
                "A region of icy objects beyond Neptune",
                "The outer edge of the Sun's atmosphere",
                "A type of comet"
            ],
            correctAnswer: 1,
            explanation: "The Kuiper Belt is a region beyond Neptune containing many icy objects, including dwarf planets like Pluto and short-period comets.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 7,
            question: "How many planets are in our Solar System?",
            options: [
                "7",
                "8",
                "9",
                "10"
            ],
            correctAnswer: 1,
            explanation: "There are 8 planets in our Solar System: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, and Neptune. Pluto was reclassified as a dwarf planet in 2006.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 8,
            question: "What causes comets to develop tails?",
            options: [
                "Solar wind",
                "Gravitational pull from planets",
                "Heat from the Sun causing ice to vaporize",
                "Collisions with asteroids"
            ],
            correctAnswer: 2,
            explanation: "When comets approach the Sun, heat causes their icy surfaces to vaporize, creating a coma and tails that point away from the Sun.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 9,
            question: "What is the ecliptic plane?",
            options: [
                "The plane of Earth's orbit around the Sun",
                "The plane of the Moon's orbit around Earth",
                "The plane of the asteroid belt",
                "The plane of the Milky Way galaxy"
            ],
            correctAnswer: 0,
            explanation: "The ecliptic plane is the plane of Earth's orbit around the Sun. Most planets orbit close to this plane.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 10,
            question: "Which planet is closest to the Sun?",
            options: [
                "Venus",
                "Earth",
                "Mercury",
                "Mars"
            ],
            correctAnswer: 2,
            explanation: "Mercury is the closest planet to the Sun, orbiting at an average distance of 0.39 AU.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 11,
            question: "What is the primary mechanism that prevents the asteroid belt from coalescing into a planet?",
            options: [
                "Lack of sufficient material",
                "Jupiter's gravitational perturbations",
                "High collision velocities",
                "Solar wind pressure"
            ],
            correctAnswer: 1,
            explanation: "Jupiter's strong gravitational influence creates orbital resonances that prevent asteroids from coalescing into a planet. These resonances increase collision velocities and eject material from stable orbits.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 12,
            question: "What is the difference between the Kuiper Belt and the Oort Cloud?",
            options: [
                "The Kuiper Belt is closer and disk-shaped; the Oort Cloud is distant and spherical",
                "They are the same thing",
                "The Oort Cloud contains asteroids; the Kuiper Belt contains comets",
                "The Kuiper Belt is spherical; the Oort Cloud is disk-shaped"
            ],
            correctAnswer: 0,
            explanation: "The Kuiper Belt is a disk-shaped region beyond Neptune (30-50 AU) containing icy objects. The Oort Cloud is a distant spherical shell (2,000-100,000 AU) surrounding the Solar System, the source of long-period comets.",
            topic: "Solar System"
        ),
        QuizQuestion(
            id: 13,
            question: "Why do comets develop two distinct tails, and what causes each type?",
            options: [
                "One tail is from dust, one from gas; both point away from the Sun due to solar wind and radiation pressure",
                "One tail is from ice, one from rock; they point in different directions",
                "Both tails are identical; they just appear different",
                "One tail is from the nucleus, one from the coma; they point toward the Sun"
            ],
            correctAnswer: 0,
            explanation: "Comets develop two tails: a dust tail (curved, reflects sunlight) and an ion tail (straight, blue, points directly away from the Sun). Both are pushed away by solar wind and radiation pressure, but the dust tail curves due to the comet's orbital motion.",
            topic: "Solar System"
        )
    ]
    
    // Planets Questions
    static let planetsQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "Which planet is known as the 'Red Planet'?",
            options: [
                "Venus",
                "Mars",
                "Jupiter",
                "Saturn"
            ],
            correctAnswer: 1,
            explanation: "Mars is called the 'Red Planet' because iron oxide (rust) on its surface gives it a reddish appearance.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 2,
            question: "Which planet has the fastest winds in the Solar System?",
            options: [
                "Jupiter",
                "Saturn",
                "Uranus",
                "Neptune"
            ],
            correctAnswer: 3,
            explanation: "Neptune has the fastest winds in the Solar System, reaching speeds up to 2,100 km/h (1,300 mph).",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 3,
            question: "Which planet rotates on its side?",
            options: [
                "Venus",
                "Uranus",
                "Neptune",
                "Pluto"
            ],
            correctAnswer: 1,
            explanation: "Uranus rotates on its side at a 98° angle, likely due to a massive collision in its past.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 4,
            question: "Which planet is the hottest in our Solar System?",
            options: [
                "Mercury",
                "Venus",
                "Earth",
                "Mars"
            ],
            correctAnswer: 1,
            explanation: "Venus is the hottest planet with surface temperatures around 462°C (864°F) due to its thick, greenhouse gas atmosphere.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 5,
            question: "Which planet has the most moons?",
            options: [
                "Jupiter",
                "Saturn",
                "Uranus",
                "Neptune"
            ],
            correctAnswer: 1,
            explanation: "Saturn has 82 known moons, more than any other planet. Jupiter has 79 known moons.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 6,
            question: "What is the Great Red Spot on Jupiter?",
            options: [
                "A massive volcano",
                "A giant storm",
                "A large crater",
                "An ocean of liquid hydrogen"
            ],
            correctAnswer: 1,
            explanation: "The Great Red Spot is a giant storm on Jupiter that has been raging for at least 400 years. It's larger than Earth.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 7,
            question: "Which planet is famous for its ring system?",
            options: [
                "Jupiter",
                "Saturn",
                "Uranus",
                "Neptune"
            ],
            correctAnswer: 1,
            explanation: "Saturn is famous for its spectacular ring system, made of ice particles and rocky debris.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 8,
            question: "Which planet has the longest day?",
            options: [
                "Mercury",
                "Venus",
                "Earth",
                "Mars"
            ],
            correctAnswer: 1,
            explanation: "Venus has the longest day of any planet - one day on Venus lasts 243 Earth days, longer than its year!",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 9,
            question: "What are the four Galilean moons?",
            options: [
                "The four largest moons of Jupiter",
                "The four largest moons of Saturn",
                "The four moons of Mars",
                "The four moons of Neptune"
            ],
            correctAnswer: 0,
            explanation: "The Galilean moons (Io, Europa, Ganymede, and Callisto) are the four largest moons of Jupiter, discovered by Galileo in 1610.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 10,
            question: "Which planet has the largest volcano in the Solar System?",
            options: [
                "Earth",
                "Mars",
                "Venus",
                "Jupiter"
            ],
            correctAnswer: 1,
            explanation: "Mars has Olympus Mons, the largest volcano in the Solar System, standing about 22 km (14 miles) high.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 11,
            question: "What makes Earth unique among the planets?",
            options: [
                "It has water",
                "It has life",
                "It has a moon",
                "It has an atmosphere"
            ],
            correctAnswer: 1,
            explanation: "Earth is the only known planet with life. While other planets may have water or atmospheres, Earth is unique in supporting life.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 12,
            question: "Which planet has retrograde rotation (rotates backwards)?",
            options: [
                "Mercury",
                "Venus",
                "Uranus",
                "Neptune"
            ],
            correctAnswer: 1,
            explanation: "Venus rotates backwards (retrograde rotation), meaning the Sun rises in the west and sets in the east on Venus.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 13,
            question: "What is the smallest planet in our Solar System?",
            options: [
                "Mars",
                "Mercury",
                "Pluto",
                "Earth"
            ],
            correctAnswer: 1,
            explanation: "Mercury is the smallest planet in our Solar System, with a diameter of about 4,879 km (3,032 miles).",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 14,
            question: "Which planet is the largest?",
            options: [
                "Saturn",
                "Jupiter",
                "Neptune",
                "Uranus"
            ],
            correctAnswer: 1,
            explanation: "Jupiter is the largest planet in our Solar System, with a mass greater than all other planets combined.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 15,
            question: "What type of planets are Uranus and Neptune?",
            options: [
                "Terrestrial planets",
                "Gas giants",
                "Ice giants",
                "Dwarf planets"
            ],
            correctAnswer: 2,
            explanation: "Uranus and Neptune are ice giants, composed primarily of water, methane, and ammonia ices, unlike the gas giants Jupiter and Saturn.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 16,
            question: "Why does Venus have a runaway greenhouse effect while Earth does not?",
            options: [
                "Venus is closer to the Sun",
                "Venus has more carbon dioxide and no mechanism to remove it, while Earth has carbon cycles",
                "Venus has no magnetic field",
                "Venus rotates backwards"
            ],
            correctAnswer: 1,
            explanation: "Venus has a thick atmosphere of carbon dioxide with no plate tectonics or oceans to sequester carbon. Earth's carbon cycle (oceans, plants, plate tectonics) regulates CO2 levels, preventing a runaway greenhouse effect.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 17,
            question: "What causes the extreme temperature variations on Mercury despite its proximity to the Sun?",
            options: [
                "Mercury's elliptical orbit",
                "Mercury's lack of atmosphere to retain heat",
                "Mercury's slow rotation creating long day/night cycles",
                "All of the above"
            ],
            correctAnswer: 3,
            explanation: "Mercury experiences extreme temperatures (-173°C to 427°C) due to its lack of atmosphere (no heat retention), slow rotation (59 Earth days per day), and elliptical orbit causing varying solar distance.",
            topic: "Planets"
        ),
        QuizQuestion(
            id: 18,
            question: "What is the primary difference between the formation of terrestrial and gas giant planets?",
            options: [
                "Terrestrial planets formed closer to the Sun where only rocky materials could condense",
                "Gas giants formed first and captured terrestrial planets",
                "Terrestrial planets are older",
                "There is no difference"
            ],
            correctAnswer: 0,
            explanation: "Terrestrial planets formed in the inner Solar System where temperatures were high enough that only rocky and metallic materials could condense. Gas giants formed beyond the frost line where ices could condense, allowing them to accumulate massive atmospheres.",
            topic: "Planets"
        )
    ]
    
    // Stars Questions
    static let starsQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What is the closest star to Earth?",
            options: [
                "Alpha Centauri",
                "Sirius",
                "The Sun",
                "Proxima Centauri"
            ],
            correctAnswer: 2,
            explanation: "The Sun is the closest star to Earth at approximately 93 million miles (150 million kilometers) away.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 2,
            question: "What process powers stars?",
            options: [
                "Chemical combustion",
                "Nuclear fusion",
                "Gravitational compression",
                "Radioactive decay"
            ],
            correctAnswer: 1,
            explanation: "Stars are powered by nuclear fusion, where hydrogen atoms combine to form helium, releasing enormous amounts of energy.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 3,
            question: "What type of star is our Sun?",
            options: [
                "O-type",
                "B-type",
                "G-type",
                "M-type"
            ],
            correctAnswer: 2,
            explanation: "Our Sun is a G-type main-sequence star (G2V), which means it's a yellow star with a surface temperature around 5,500°C.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 4,
            question: "Where do stars form?",
            options: [
                "In black holes",
                "In nebulae",
                "In galaxies",
                "In supernovae"
            ],
            correctAnswer: 1,
            explanation: "Stars form in giant molecular clouds called nebulae, where gravity causes dense regions to collapse and heat up.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 5,
            question: "What happens to a low-mass star like our Sun at the end of its life?",
            options: [
                "It becomes a supernova",
                "It becomes a red giant, then a white dwarf",
                "It becomes a black hole",
                "It becomes a neutron star"
            ],
            correctAnswer: 1,
            explanation: "Low-mass stars like our Sun expand into red giants, then expel their outer layers to form planetary nebulae, leaving behind white dwarf cores.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 6,
            question: "What is a supernova?",
            options: [
                "A new star being born",
                "The explosive death of a massive star",
                "A type of galaxy",
                "A black hole"
            ],
            correctAnswer: 1,
            explanation: "A supernova is the explosive death of a massive star, releasing enormous energy and creating heavy elements.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 7,
            question: "What color are the hottest stars?",
            options: [
                "Red",
                "Yellow",
                "Blue",
                "White"
            ],
            correctAnswer: 2,
            explanation: "The hottest stars appear blue or blue-white. Cooler stars appear red. This follows Wien's law relating temperature to color.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 8,
            question: "What is the main sequence?",
            options: [
                "A sequence of planets",
                "The phase where stars fuse hydrogen in their cores",
                "A type of galaxy",
                "A constellation"
            ],
            correctAnswer: 1,
            explanation: "The main sequence is the phase where stars spend most of their lives, fusing hydrogen into helium in their cores.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 9,
            question: "What is a white dwarf?",
            options: [
                "A young star",
                "The dense remnant of a low-mass star",
                "A type of planet",
                "A black hole"
            ],
            correctAnswer: 1,
            explanation: "A white dwarf is the hot, dense core remnant of a low-mass star that has exhausted its nuclear fuel.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 10,
            question: "What determines a star's color?",
            options: [
                "Its size",
                "Its age",
                "Its surface temperature",
                "Its distance from Earth"
            ],
            correctAnswer: 2,
            explanation: "A star's color is determined by its surface temperature. Hotter stars are blue, cooler stars are red.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 11,
            question: "What is a red giant?",
            options: [
                "A large red planet",
                "An expanded star that has exhausted its core hydrogen",
                "A type of galaxy",
                "A young star"
            ],
            correctAnswer: 1,
            explanation: "A red giant is an expanded star in a late stage of evolution, having exhausted the hydrogen in its core and begun fusing helium.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 12,
            question: "How old is our Sun?",
            options: [
                "1 billion years",
                "4.6 billion years",
                "10 billion years",
                "13.8 billion years"
            ],
            correctAnswer: 1,
            explanation: "Our Sun is approximately 4.6 billion years old and is about halfway through its main sequence lifetime.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 13,
            question: "What is the Chandrasekhar limit and why is it significant?",
            options: [
                "The maximum mass for a white dwarf (~1.4 solar masses); above this, electron degeneracy pressure fails",
                "The minimum mass for star formation",
                "The maximum distance between binary stars",
                "The temperature limit for nuclear fusion"
            ],
            correctAnswer: 0,
            explanation: "The Chandrasekhar limit (about 1.4 solar masses) is the maximum mass a white dwarf can have. Above this limit, electron degeneracy pressure cannot support the star against gravity, causing it to collapse into a neutron star or explode as a Type Ia supernova.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 14,
            question: "What is the difference between a Type I and Type II supernova?",
            options: [
                "Type I occurs in binary systems; Type II occurs in single massive stars",
                "Type I is brighter; Type II is dimmer",
                "Type I forms black holes; Type II forms neutron stars",
                "There is no difference"
            ],
            correctAnswer: 0,
            explanation: "Type I supernovae occur in binary systems when a white dwarf accretes mass and exceeds the Chandrasekhar limit. Type II supernovae occur when massive single stars (8+ solar masses) exhaust their nuclear fuel and collapse.",
            topic: "Stars"
        ),
        QuizQuestion(
            id: 15,
            question: "Why do massive stars have shorter lifespans than low-mass stars?",
            options: [
                "They burn fuel faster due to higher core temperatures and pressures",
                "They are hotter",
                "They are larger",
                "They form later"
            ],
            correctAnswer: 0,
            explanation: "Massive stars have much higher core temperatures and pressures, causing nuclear fusion to proceed at exponentially faster rates. A star 10 times more massive than the Sun burns its fuel about 1,000 times faster, living only millions of years instead of billions.",
            topic: "Stars"
        )
    ]
    
    // Galaxies Questions
    static let galaxiesQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What type of galaxy is the Milky Way?",
            options: [
                "Elliptical",
                "Spiral",
                "Irregular",
                "Lenticular"
            ],
            correctAnswer: 1,
            explanation: "The Milky Way is a barred spiral galaxy with distinctive spiral arms extending from a central bar structure.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 2,
            question: "How many stars are estimated to be in the Milky Way?",
            options: [
                "10-50 billion",
                "100-200 billion",
                "200-400 billion",
                "1 trillion"
            ],
            correctAnswer: 2,
            explanation: "The Milky Way contains an estimated 200-400 billion stars, though the exact number is difficult to determine.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 3,
            question: "What is the nearest large galaxy to the Milky Way?",
            options: [
                "Triangulum Galaxy",
                "Andromeda Galaxy",
                "Whirlpool Galaxy",
                "Sombrero Galaxy"
            ],
            correctAnswer: 1,
            explanation: "The Andromeda Galaxy is the nearest large galaxy to the Milky Way, located about 2.5 million light-years away.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 4,
            question: "What are the three main types of galaxies?",
            options: [
                "Spiral, Elliptical, Irregular",
                "Large, Medium, Small",
                "Young, Middle-aged, Old",
                "Bright, Dim, Dark"
            ],
            correctAnswer: 0,
            explanation: "Galaxies are classified into three main types based on shape: spiral (with arms), elliptical (spherical), and irregular (no defined shape).",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 5,
            question: "What is a light-year?",
            options: [
                "A unit of time",
                "The distance light travels in one year",
                "The age of a star",
                "A type of galaxy"
            ],
            correctAnswer: 1,
            explanation: "A light-year is the distance light travels in one year, approximately 9.5 trillion kilometers (5.9 trillion miles).",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 6,
            question: "How wide is the Milky Way galaxy?",
            options: [
                "10,000 light-years",
                "50,000 light-years",
                "100,000 light-years",
                "1 million light-years"
            ],
            correctAnswer: 2,
            explanation: "The Milky Way is approximately 100,000 light-years across, with our Solar System located about 27,000 light-years from the center.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 7,
            question: "What is dark matter?",
            options: [
                "Black holes",
                "Invisible matter that provides gravitational structure",
                "Dead stars",
                "Empty space"
            ],
            correctAnswer: 1,
            explanation: "Dark matter is invisible matter that doesn't emit or absorb light but provides gravitational structure, holding galaxies together.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 8,
            question: "What happens when galaxies collide?",
            options: [
                "They explode",
                "They merge and trigger star formation",
                "They bounce off each other",
                "Nothing happens"
            ],
            correctAnswer: 1,
            explanation: "When galaxies collide, they merge over billions of years, triggering bursts of star formation and creating new structures.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 9,
            question: "What is at the center of most galaxies?",
            options: [
                "A black hole",
                "A supermassive black hole",
                "A cluster of stars",
                "Dark matter"
            ],
            correctAnswer: 1,
            explanation: "Most galaxies, including the Milky Way, have a supermassive black hole at their center. Ours is called Sagittarius A*.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 10,
            question: "How many galaxies are estimated to be in the observable universe?",
            options: [
                "Millions",
                "Billions",
                "Hundreds of billions",
                "Trillions"
            ],
            correctAnswer: 2,
            explanation: "The observable universe contains an estimated hundreds of billions to trillions of galaxies.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 11,
            question: "What is the difference between a barred spiral and a regular spiral galaxy?",
            options: [
                "Barred spirals have a central bar structure from which arms extend; regular spirals have arms extending directly from the center",
                "Barred spirals are larger",
                "Regular spirals are older",
                "There is no difference"
            ],
            correctAnswer: 0,
            explanation: "Barred spiral galaxies have a central bar-shaped structure of stars, with spiral arms extending from the ends of the bar. Regular spiral galaxies have arms that extend directly from a central bulge. The Milky Way is a barred spiral.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 12,
            question: "What evidence suggests that most galaxies contain supermassive black holes at their centers?",
            options: [
                "Direct imaging of all galaxies",
                "Observations of rapid star motions and high-energy emissions near galactic centers",
                "Theoretical predictions only",
                "Gravitational wave detections"
            ],
            correctAnswer: 1,
            explanation: "Observations of stars orbiting rapidly near galactic centers, along with high-energy X-ray and radio emissions, provide strong evidence for supermassive black holes. The Event Horizon Telescope directly imaged the black hole in M87, confirming this.",
            topic: "Galaxies"
        ),
        QuizQuestion(
            id: 13,
            question: "What is the Local Group?",
            options: [
                "A type of galaxy",
                "A galaxy cluster containing the Milky Way, Andromeda, and about 50 other galaxies",
                "A constellation",
                "A region of space"
            ],
            correctAnswer: 1,
            explanation: "The Local Group is a small galaxy group containing the Milky Way, Andromeda Galaxy, Triangulum Galaxy, and about 50 smaller galaxies, all gravitationally bound together over a region about 10 million light-years across.",
            topic: "Galaxies"
        )
    ]
    
    // Cosmology Questions
    static let cosmologyQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What is the approximate age of the universe?",
            options: [
                "4.6 billion years",
                "13.8 billion years",
                "1 billion years",
                "25 billion years"
            ],
            correctAnswer: 1,
            explanation: "The universe is approximately 13.8 billion years old, determined through cosmic microwave background radiation studies.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 2,
            question: "What is the Big Bang theory?",
            options: [
                "An explosion in space",
                "The expansion of space itself from a hot, dense state",
                "The collision of two universes",
                "The formation of the first star"
            ],
            correctAnswer: 1,
            explanation: "The Big Bang theory describes how the universe began as an expansion of space itself from an extremely hot, dense point, not an explosion in space.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 3,
            question: "What is the cosmic microwave background (CMB)?",
            options: [
                "Light from the first stars",
                "The oldest light in the universe",
                "Radiation from black holes",
                "Light from distant galaxies"
            ],
            correctAnswer: 1,
            explanation: "The CMB is the oldest light in the universe, released 380,000 years after the Big Bang when atoms first formed.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 4,
            question: "What percentage of the universe is dark matter?",
            options: [
                "5%",
                "27%",
                "50%",
                "68%"
            ],
            correctAnswer: 1,
            explanation: "Dark matter makes up approximately 27% of the universe's mass-energy content. Ordinary matter is only about 5%.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 5,
            question: "What is dark energy?",
            options: [
                "Black holes",
                "A mysterious force causing universe expansion to accelerate",
                "Dead stars",
                "Empty space"
            ],
            correctAnswer: 1,
            explanation: "Dark energy is a mysterious force that makes up about 68% of the universe and is causing the expansion of the universe to accelerate.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 6,
            question: "What evidence supports the Big Bang theory?",
            options: [
                "Only the CMB",
                "CMB, abundance of light elements, and galaxy redshift",
                "Only galaxy movements",
                "Only star formation"
            ],
            correctAnswer: 1,
            explanation: "Multiple lines of evidence support the Big Bang: cosmic microwave background radiation, the abundance of light elements, and the redshift of distant galaxies showing expansion.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 7,
            question: "What is inflation in cosmology?",
            options: [
                "The expansion of the universe today",
                "Rapid expansion in the first fraction of a second after the Big Bang",
                "The formation of stars",
                "Galaxy collisions"
            ],
            correctAnswer: 1,
            explanation: "Inflation refers to the rapid expansion of the universe in the first tiny fraction of a second after the Big Bang, explaining the universe's uniformity.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 8,
            question: "What is the future of the universe according to current observations?",
            options: [
                "It will collapse",
                "It will expand forever and become cold and dark",
                "It will stop expanding",
                "It will contract and expand in cycles"
            ],
            correctAnswer: 1,
            explanation: "Based on current observations, the universe will continue expanding forever, eventually becoming cold and dark as stars burn out (Heat Death scenario).",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 9,
            question: "What percentage of the universe is ordinary matter?",
            options: [
                "5%",
                "27%",
                "50%",
                "68%"
            ],
            correctAnswer: 0,
            explanation: "Ordinary matter (atoms, stars, planets) makes up only about 5% of the universe. The rest is dark matter (27%) and dark energy (68%).",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 10,
            question: "What does the redshift of distant galaxies tell us?",
            options: [
                "They are moving toward us",
                "The universe is expanding",
                "They are getting closer",
                "They are stationary"
            ],
            correctAnswer: 1,
            explanation: "The redshift of distant galaxies shows that the universe is expanding, with galaxies moving away from each other.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 11,
            question: "What is the difference between cosmological redshift and Doppler redshift?",
            options: [
                "Cosmological redshift is due to space expansion; Doppler redshift is due to motion through space",
                "They are the same thing",
                "Cosmological redshift is for nearby objects; Doppler redshift is for distant objects",
                "Doppler redshift is stronger"
            ],
            correctAnswer: 0,
            explanation: "Cosmological redshift occurs because space itself is expanding, stretching light wavelengths as they travel. Doppler redshift occurs when objects move through space. For very distant galaxies, cosmological redshift dominates.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 12,
            question: "What is the horizon problem in cosmology, and how does inflation solve it?",
            options: [
                "The universe appears uniform despite regions that couldn't have been in contact; inflation explains rapid early expansion",
                "The universe is too old",
                "There are too many galaxies",
                "Dark matter distribution"
            ],
            correctAnswer: 0,
            explanation: "The horizon problem: the universe appears uniform (same temperature everywhere) despite regions that were too far apart to have been in causal contact. Inflation theory explains this by proposing rapid expansion in the first fraction of a second, allowing all regions to be in contact before expanding apart.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 13,
            question: "What is the flatness problem, and what does it suggest about the universe?",
            options: [
                "The universe's density is very close to critical density; suggests fine-tuning or inflation",
                "The universe is flat like a pancake",
                "The universe has no curvature",
                "The universe is two-dimensional"
            ],
            correctAnswer: 0,
            explanation: "The flatness problem: observations show the universe's density is extremely close to the critical density (flat geometry). This requires fine-tuning to 1 part in 10^60. Inflation theory naturally explains this by driving the universe toward flatness during rapid expansion.",
            topic: "Cosmology"
        )
    ]
    
    // Exoplanets Questions
    static let exoplanetsQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What is an exoplanet?",
            options: [
                "A planet in our Solar System",
                "A planet orbiting a star other than the Sun",
                "A moon",
                "An asteroid"
            ],
            correctAnswer: 1,
            explanation: "An exoplanet is a planet that orbits a star other than our Sun. Scientists have discovered over 5,000 confirmed exoplanets.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 2,
            question: "What is the transit method?",
            options: [
                "Detecting wobbles in a star's motion",
                "Detecting tiny dips in star brightness when a planet passes in front",
                "Taking pictures of planets",
                "Measuring planet temperatures"
            ],
            correctAnswer: 1,
            explanation: "The transit method detects exoplanets by observing tiny dips in a star's brightness when a planet passes in front of it, blocking some light.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 3,
            question: "What is the habitable zone?",
            options: [
                "A region where planets can form",
                "A region where liquid water could exist on a planet's surface",
                "A region with no asteroids",
                "A region near black holes"
            ],
            correctAnswer: 1,
            explanation: "The habitable zone (or Goldilocks zone) is the region around a star where conditions might allow liquid water to exist on a planet's surface.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 4,
            question: "Which space telescope has found the most exoplanets?",
            options: [
                "Hubble",
                "Kepler",
                "James Webb",
                "Spitzer"
            ],
            correctAnswer: 1,
            explanation: "The Kepler Space Telescope discovered thousands of exoplanets using the transit method, revolutionizing our understanding of planets beyond our Solar System.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 5,
            question: "What is a 'Hot Jupiter'?",
            options: [
                "Jupiter during summer",
                "A gas giant planet very close to its star",
                "A type of star",
                "A moon of Jupiter"
            ],
            correctAnswer: 1,
            explanation: "Hot Jupiters are gas giant planets that orbit very close to their stars, completing orbits in just days and having extremely high temperatures.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 6,
            question: "What is a 'Super-Earth'?",
            options: [
                "Earth in the future",
                "A rocky planet larger than Earth but smaller than Neptune",
                "A gas giant",
                "A type of star"
            ],
            correctAnswer: 1,
            explanation: "Super-Earths are rocky planets larger than Earth but smaller than Neptune. They may or may not have atmospheres.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 7,
            question: "What is the radial velocity method?",
            options: [
                "Detecting planet transits",
                "Detecting wobbles in a star's motion caused by planet's gravity",
                "Direct imaging",
                "Measuring star brightness"
            ],
            correctAnswer: 1,
            explanation: "The radial velocity method detects exoplanets by measuring tiny wobbles in a star's motion caused by the gravitational pull of orbiting planets.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 8,
            question: "When was the first exoplanet discovered?",
            options: [
                "1992",
                "2000",
                "2010",
                "2015"
            ],
            correctAnswer: 0,
            explanation: "The first confirmed exoplanets were discovered in 1992, orbiting a pulsar. The first exoplanet around a Sun-like star was found in 1995.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 9,
            question: "What makes direct imaging of exoplanets difficult?",
            options: [
                "They are too small",
                "Stars are much brighter than planets",
                "They are too far away",
                "They don't emit light"
            ],
            correctAnswer: 1,
            explanation: "Direct imaging is difficult because stars are millions of times brighter than their planets, making planets hard to see in the glare.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 10,
            question: "What is TESS?",
            options: [
                "A type of exoplanet",
                "A space telescope searching for exoplanets",
                "A detection method",
                "A star"
            ],
            correctAnswer: 1,
            explanation: "TESS (Transiting Exoplanet Survey Satellite) is a NASA space telescope that searches for exoplanets using the transit method.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 11,
            question: "Why are Hot Jupiters easier to detect than Earth-like planets?",
            options: [
                "They are larger and cause bigger brightness dips during transits",
                "They are brighter",
                "They are closer to Earth",
                "They emit more light"
            ],
            correctAnswer: 0,
            explanation: "Hot Jupiters are easier to detect because their large size causes more significant brightness dips when transiting their stars (larger transit depth), and their short orbital periods mean transits occur frequently. Earth-sized planets cause much smaller, harder-to-detect dips.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 12,
            question: "What is the significance of finding exoplanets in the habitable zone?",
            options: [
                "They are guaranteed to have life",
                "They could potentially have liquid water on their surface, a key requirement for life as we know it",
                "They are always Earth-like",
                "They are always rocky planets"
            ],
            correctAnswer: 1,
            explanation: "The habitable zone is where a planet could potentially have liquid water on its surface, which is considered essential for life as we know it. However, other factors (atmosphere, composition, magnetic field) also matter, and being in the habitable zone doesn't guarantee life or even liquid water.",
            topic: "Exoplanets"
        ),
        QuizQuestion(
            id: 13,
            question: "What is the difference between the transit method and the radial velocity method in terms of what they reveal?",
            options: [
                "Transit reveals size and orbital period; radial velocity reveals mass",
                "They reveal the same information",
                "Transit reveals composition; radial velocity reveals temperature",
                "Transit reveals distance; radial velocity reveals brightness"
            ],
            correctAnswer: 0,
            explanation: "The transit method reveals a planet's size (from transit depth) and orbital period (from transit timing). The radial velocity method reveals a planet's mass (from the star's wobble amplitude). Combining both methods allows calculation of planet density.",
            topic: "Exoplanets"
        )
    ]
    
    // Black Holes Questions
    static let blackHolesQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What is a black hole?",
            options: [
                "A dark planet",
                "A region where gravity is so strong nothing can escape",
                "An empty space",
                "A type of star"
            ],
            correctAnswer: 1,
            explanation: "A black hole is a region in space where gravity is so strong that nothing, not even light, can escape once it crosses the event horizon.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 2,
            question: "What is the event horizon?",
            options: [
                "The surface of a black hole",
                "The boundary beyond which nothing can escape",
                "The center of a black hole",
                "The accretion disk"
            ],
            correctAnswer: 1,
            explanation: "The event horizon is the boundary around a black hole. Once something crosses this point, it cannot escape, not even light.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 3,
            question: "How do stellar-mass black holes form?",
            options: [
                "From planet collisions",
                "From collapsed massive stars",
                "From galaxy mergers",
                "From dark matter"
            ],
            correctAnswer: 1,
            explanation: "Stellar-mass black holes form when massive stars (at least 3 times the Sun's mass) collapse at the end of their lives in supernova explosions.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 4,
            question: "What is at the center of most galaxies?",
            options: [
                "A star cluster",
                "A supermassive black hole",
                "A planet",
                "Dark matter only"
            ],
            correctAnswer: 1,
            explanation: "Most galaxies, including the Milky Way, have a supermassive black hole at their center. Ours is called Sagittarius A*.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 5,
            question: "What is an accretion disk?",
            options: [
                "The event horizon",
                "Hot matter spiraling into a black hole",
                "The singularity",
                "A type of galaxy"
            ],
            correctAnswer: 1,
            explanation: "An accretion disk is a hot, glowing disk of matter spiraling into a black hole, heated to extreme temperatures by friction and gravity.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 6,
            question: "What is the singularity?",
            options: [
                "The event horizon",
                "The infinitely dense point at a black hole's center",
                "The accretion disk",
                "The jets"
            ],
            correctAnswer: 1,
            explanation: "The singularity is the infinitely dense point at the center of a black hole where all matter is compressed to zero volume.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 7,
            question: "When was the first image of a black hole captured?",
            options: [
                "2015",
                "2019",
                "2020",
                "2022"
            ],
            correctAnswer: 1,
            explanation: "The first image of a black hole (M87*) was captured in 2019 by the Event Horizon Telescope, a global network of radio telescopes.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 8,
            question: "What are gravitational waves?",
            options: [
                "Waves in the ocean",
                "Ripples in spacetime from massive objects",
                "Light waves",
                "Sound waves"
            ],
            correctAnswer: 1,
            explanation: "Gravitational waves are ripples in spacetime caused by massive accelerating objects, such as merging black holes, first detected in 2015.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 9,
            question: "What is Hawking radiation?",
            options: [
                "Radiation from the accretion disk",
                "Theoretical radiation from black holes",
                "Light from jets",
                "Heat from the event horizon"
            ],
            correctAnswer: 1,
            explanation: "Hawking radiation is theoretical radiation predicted by Stephen Hawking that black holes should emit, causing them to slowly evaporate over time.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 10,
            question: "What is the mass range of stellar-mass black holes?",
            options: [
                "1-10 times the Sun",
                "3-100 times the Sun",
                "100-1000 times the Sun",
                "Millions of times the Sun"
            ],
            correctAnswer: 1,
            explanation: "Stellar-mass black holes typically range from 3 to 100 times the mass of the Sun, formed from collapsed massive stars.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 11,
            question: "What is spaghettification, and when does it occur?",
            options: [
                "The stretching of objects by extreme tidal forces near a black hole",
                "A type of black hole",
                "The formation of black holes",
                "A type of accretion disk"
            ],
            correctAnswer: 0,
            explanation: "Spaghettification (tidal disruption) occurs when an object approaches a black hole. The gravitational force on the side closer to the black hole is much stronger than on the far side, stretching the object into a long, thin shape like spaghetti.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 12,
            question: "What is the Schwarzschild radius?",
            options: [
                "The distance from a black hole where escape velocity equals the speed of light",
                "The size of the accretion disk",
                "The distance to the nearest black hole",
                "The radius of a neutron star"
            ],
            correctAnswer: 0,
            explanation: "The Schwarzschild radius is the radius of the event horizon for a non-rotating black hole. At this distance, the escape velocity equals the speed of light. For a black hole with mass M, it's approximately 2GM/c², where G is the gravitational constant and c is the speed of light.",
            topic: "Black Holes"
        ),
        QuizQuestion(
            id: 13,
            question: "What information paradox is associated with black holes?",
            options: [
                "The apparent loss of information when matter falls into a black hole, violating quantum mechanics",
                "Black holes don't exist",
                "Black holes are too massive",
                "Black holes emit too much radiation"
            ],
            correctAnswer: 0,
            explanation: "The black hole information paradox: quantum mechanics says information cannot be destroyed, but black holes appear to destroy information when matter falls in. Hawking radiation suggests information might be encoded in the radiation, but this remains an active area of research.",
            topic: "Black Holes"
        )
    ]
    
    // Nebulae Questions
    static let nebulaeQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What is a nebula?",
            options: [
                "A type of star",
                "A cloud of gas and dust in space",
                "A planet",
                "A galaxy"
            ],
            correctAnswer: 1,
            explanation: "A nebula is a vast cloud of gas and dust in space. They serve as stellar nurseries where new stars form.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 2,
            question: "What is an emission nebula?",
            options: [
                "A nebula that blocks light",
                "A nebula that glows with its own light",
                "A nebula that reflects light",
                "A dead star"
            ],
            correctAnswer: 1,
            explanation: "An emission nebula glows with its own light when gas is ionized (excited) by nearby hot stars, often appearing red or pink.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 3,
            question: "What is the Orion Nebula?",
            options: [
                "A planet",
                "A famous stellar nursery",
                "A galaxy",
                "A black hole"
            ],
            correctAnswer: 1,
            explanation: "The Orion Nebula is a famous emission nebula and stellar nursery, visible to the naked eye, where new stars are actively forming.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 4,
            question: "What is a planetary nebula?",
            options: [
                "A nebula related to planets",
                "A shell of gas expelled by a dying star",
                "A nebula that forms planets",
                "A type of planet"
            ],
            correctAnswer: 1,
            explanation: "A planetary nebula is a shell of gas expelled by a medium-mass star near the end of its life. Despite the name, it's not related to planets.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 5,
            question: "What is a supernova remnant?",
            options: [
                "A new star",
                "The remains of a massive star explosion",
                "A planet",
                "A galaxy"
            ],
            correctAnswer: 1,
            explanation: "A supernova remnant is the expanding shell of gas and debris left behind after a massive star explodes in a supernova.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 6,
            question: "What is a dark nebula?",
            options: [
                "A nebula that glows",
                "A dense cloud that blocks background light",
                "A dead star",
                "A black hole"
            ],
            correctAnswer: 1,
            explanation: "A dark nebula is a dense cloud of dust that blocks light from stars behind it, appearing as dark patches against the starry background.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 7,
            question: "What is a reflection nebula?",
            options: [
                "A nebula that glows",
                "A nebula that reflects light from nearby stars",
                "A dark cloud",
                "A planetary nebula"
            ],
            correctAnswer: 1,
            explanation: "A reflection nebula reflects light from nearby stars, often appearing blue because blue light scatters more effectively than red light.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 8,
            question: "What role do nebulae play in star formation?",
            options: [
                "They destroy stars",
                "They are stellar nurseries where stars form",
                "They are dead stars",
                "They have no role"
            ],
            correctAnswer: 1,
            explanation: "Nebulae are stellar nurseries where dense regions collapse under gravity to form protostars, which eventually become stars.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 9,
            question: "What is the Crab Nebula?",
            options: [
                "A planetary nebula",
                "A supernova remnant from 1054",
                "An emission nebula",
                "A dark nebula"
            ],
            correctAnswer: 1,
            explanation: "The Crab Nebula is a supernova remnant from a star that exploded in 1054 AD, observed by Chinese astronomers.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 10,
            question: "What causes nebulae to glow?",
            options: [
                "Their own heat",
                "Ionization by nearby hot stars",
                "Reflected sunlight",
                "Internal nuclear reactions"
            ],
            correctAnswer: 1,
            explanation: "Emission nebulae glow because hot, massive stars nearby ionize the gas, causing it to emit light at specific wavelengths.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 11,
            question: "What is the difference between HII regions and planetary nebulae?",
            options: [
                "HII regions are star-forming regions; planetary nebulae are from dying stars",
                "They are the same thing",
                "HII regions are smaller",
                "Planetary nebulae form planets"
            ],
            correctAnswer: 0,
            explanation: "HII regions (emission nebulae) are areas where new stars are forming, ionized by young, hot stars. Planetary nebulae are shells of gas expelled by dying medium-mass stars (misleading name - not related to planets).",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 12,
            question: "Why do reflection nebulae appear blue while emission nebulae often appear red?",
            options: [
                "Reflection nebulae scatter blue light more effectively; emission nebulae emit red light from hydrogen",
                "They are made of different materials",
                "Reflection nebulae are hotter",
                "Emission nebulae are colder"
            ],
            correctAnswer: 0,
            explanation: "Reflection nebulae appear blue because small dust particles scatter blue light more effectively than red light (Rayleigh scattering, like Earth's sky). Emission nebulae appear red because ionized hydrogen emits strongly in the red H-alpha spectral line.",
            topic: "Nebulae"
        ),
        QuizQuestion(
            id: 13,
            question: "What is the role of Bok globules in star formation?",
            options: [
                "They are dense, dark clouds that collapse to form protostars",
                "They prevent star formation",
                "They are remnants of dead stars",
                "They are types of planets"
            ],
            correctAnswer: 0,
            explanation: "Bok globules are small, dense, dark nebulae (a type of dark nebula) that are sites of active star formation. Their high density allows gravity to overcome pressure, causing collapse into protostars.",
            topic: "Nebulae"
        )
    ]
    
    // Asteroids Questions
    static let asteroidsQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What is an asteroid?",
            options: [
                "A small planet",
                "A rocky object smaller than a planet",
                "A type of star",
                "A moon"
            ],
            correctAnswer: 1,
            explanation: "An asteroid is a rocky object smaller than a planet, primarily found in the asteroid belt between Mars and Jupiter.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 2,
            question: "Where is the main asteroid belt located?",
            options: [
                "Between Earth and Mars",
                "Between Mars and Jupiter",
                "Between Jupiter and Saturn",
                "Beyond Neptune"
            ],
            correctAnswer: 1,
            explanation: "The main asteroid belt is located between the orbits of Mars and Jupiter, containing millions of asteroids.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 3,
            question: "What is the largest object in the asteroid belt?",
            options: [
                "Vesta",
                "Ceres",
                "Pallas",
                "Juno"
            ],
            correctAnswer: 1,
            explanation: "Ceres is the largest object in the asteroid belt and is now classified as a dwarf planet, with a diameter of about 940 km.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 4,
            question: "What is a comet?",
            options: [
                "A rocky asteroid",
                "An icy body that develops tails near the Sun",
                "A type of planet",
                "A moon"
            ],
            correctAnswer: 1,
            explanation: "A comet is an icy body composed of frozen gases, dust, and rock that develops spectacular tails when approaching the Sun.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 5,
            question: "Where do comets originate?",
            options: [
                "The asteroid belt",
                "The Kuiper Belt and Oort Cloud",
                "Between Mars and Jupiter",
                "Near the Sun"
            ],
            correctAnswer: 1,
            explanation: "Comets originate from the Kuiper Belt (beyond Neptune) and the Oort Cloud (a distant spherical shell around the Solar System).",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 6,
            question: "What are the two types of comet tails?",
            options: [
                "Hot and cold",
                "Dust tail and ion tail",
                "Long and short",
                "Bright and dim"
            ],
            correctAnswer: 1,
            explanation: "Comets have two types of tails: a dust tail (curved, reflects sunlight) and an ion tail (straight, points away from the Sun).",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 7,
            question: "What is the Oort Cloud?",
            options: [
                "A type of asteroid",
                "A distant spherical shell of comets",
                "A planet",
                "A nebula"
            ],
            correctAnswer: 1,
            explanation: "The Oort Cloud is a theoretical distant spherical shell of icy objects surrounding the Solar System, the source of long-period comets.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 8,
            question: "What happens when a meteoroid enters Earth's atmosphere?",
            options: [
                "It becomes a meteor",
                "It becomes a meteorite",
                "It becomes a comet",
                "It becomes a star"
            ],
            correctAnswer: 0,
            explanation: "When a meteoroid (small asteroid) enters Earth's atmosphere, it becomes a meteor (shooting star). If it reaches the ground, it's called a meteorite.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 9,
            question: "What is Halley's Comet?",
            options: [
                "A famous short-period comet",
                "An asteroid",
                "A planet",
                "A star"
            ],
            correctAnswer: 0,
            explanation: "Halley's Comet is a famous short-period comet that returns to the inner Solar System approximately every 76 years.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 10,
            question: "Why didn't the material in the asteroid belt form a planet?",
            options: [
                "It was too cold",
                "Jupiter's gravity prevented planet formation",
                "It was too hot",
                "There wasn't enough material"
            ],
            correctAnswer: 1,
            explanation: "Jupiter's strong gravity disrupted the formation of a planet in the asteroid belt, preventing the material from coalescing into a larger body.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 11,
            question: "What is the difference between a meteoroid, meteor, and meteorite?",
            options: [
                "Meteoroid is in space; meteor is in atmosphere; meteorite reaches the ground",
                "They are all the same",
                "Meteor is larger than meteoroid",
                "Meteorite is in space"
            ],
            correctAnswer: 0,
            explanation: "A meteoroid is a small rocky object in space. When it enters Earth's atmosphere and burns up, creating a streak of light, it's called a meteor (shooting star). If it survives and reaches the ground, it's called a meteorite.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 12,
            question: "What causes the difference between short-period and long-period comets?",
            options: [
                "Short-period comets come from the Kuiper Belt; long-period comets come from the Oort Cloud",
                "They have different compositions",
                "Short-period comets are larger",
                "Long-period comets are closer"
            ],
            correctAnswer: 0,
            explanation: "Short-period comets (orbital periods < 200 years) originate from the Kuiper Belt. Long-period comets (orbital periods > 200 years, up to millions of years) come from the distant Oort Cloud, a spherical shell surrounding the Solar System.",
            topic: "Asteroids"
        ),
        QuizQuestion(
            id: 13,
            question: "What is the Yarkovsky effect, and why is it important for asteroids?",
            options: [
                "A thermal effect that slowly changes asteroid orbits over time",
                "A collision effect",
                "A magnetic effect",
                "A gravitational effect"
            ],
            correctAnswer: 0,
            explanation: "The Yarkovsky effect is a thermal force on asteroids: sunlight heats one side, and as the asteroid rotates, it re-radiates heat, creating a small but cumulative thrust. Over millions of years, this can significantly change asteroid orbits, moving them from the asteroid belt toward Earth.",
            topic: "Asteroids"
        )
    ]
    
    // Space Exploration Questions
    static let spaceExplorationQuestions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What was the first artificial satellite?",
            options: [
                "Explorer 1",
                "Sputnik 1",
                "Vanguard 1",
                "Luna 1"
            ],
            correctAnswer: 1,
            explanation: "Sputnik 1, launched by the Soviet Union in 1957, was the first artificial satellite and marked the beginning of the Space Age.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 2,
            question: "Who was the first human in space?",
            options: [
                "Neil Armstrong",
                "Yuri Gagarin",
                "Alan Shepard",
                "John Glenn"
            ],
            correctAnswer: 1,
            explanation: "Yuri Gagarin, a Soviet cosmonaut, became the first human in space on April 12, 1961, aboard Vostok 1.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 3,
            question: "When did humans first land on the Moon?",
            options: [
                "1967",
                "1969",
                "1971",
                "1973"
            ],
            correctAnswer: 1,
            explanation: "Humans first landed on the Moon on July 20, 1969, when Apollo 11's Eagle module touched down with Neil Armstrong and Buzz Aldrin.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 4,
            question: "What is the International Space Station (ISS)?",
            options: [
                "A space telescope",
                "An orbiting laboratory",
                "A Moon base",
                "A Mars rover"
            ],
            correctAnswer: 1,
            explanation: "The ISS is an orbiting laboratory in space where astronauts conduct scientific research and test technologies for future space missions.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 5,
            question: "What is the Hubble Space Telescope?",
            options: [
                "A space station",
                "A space telescope that observes in visible and UV light",
                "A Mars rover",
                "A Moon lander"
            ],
            correctAnswer: 1,
            explanation: "The Hubble Space Telescope is a space-based observatory that has revolutionized astronomy with its observations in visible and ultraviolet light.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 6,
            question: "What is the James Webb Space Telescope?",
            options: [
                "A replacement for Hubble",
                "A space telescope optimized for infrared observations",
                "A Mars mission",
                "A Moon mission"
            ],
            correctAnswer: 1,
            explanation: "The James Webb Space Telescope is NASA's premier space telescope, optimized for infrared observations to study the early universe and exoplanets.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 7,
            question: "What is the Artemis program?",
            options: [
                "A Mars exploration program",
                "NASA's program to return humans to the Moon",
                "A space telescope",
                "An asteroid mission"
            ],
            correctAnswer: 1,
            explanation: "The Artemis program is NASA's plan to return humans to the Moon, establish a sustainable lunar presence, and prepare for future Mars missions.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 8,
            question: "What did the Voyager missions accomplish?",
            options: [
                "Landed on Mars",
                "Explored the outer planets",
                "Studied the Sun",
                "Landed on the Moon"
            ],
            correctAnswer: 1,
            explanation: "The Voyager 1 and 2 missions explored Jupiter, Saturn, Uranus, and Neptune, providing the first close-up views of these distant worlds.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 9,
            question: "What is a Mars rover?",
            options: [
                "A satellite",
                "A robotic vehicle for exploring Mars",
                "A space telescope",
                "A space station"
            ],
            correctAnswer: 1,
            explanation: "A Mars rover is a robotic vehicle designed to explore the Martian surface, collect samples, and conduct scientific experiments.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 10,
            question: "What is the goal of the Europa Clipper mission?",
            options: [
                "To study Jupiter",
                "To study Jupiter's moon Europa",
                "To land on Mars",
                "To study the Sun"
            ],
            correctAnswer: 1,
            explanation: "Europa Clipper is a planned NASA mission to study Jupiter's moon Europa, which may have a subsurface ocean that could harbor life.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 11,
            question: "What is the primary advantage of space-based telescopes over ground-based telescopes?",
            options: [
                "They are larger",
                "They avoid atmospheric distortion and can observe wavelengths blocked by Earth's atmosphere",
                "They are cheaper",
                "They are easier to maintain"
            ],
            correctAnswer: 1,
            explanation: "Space telescopes avoid atmospheric distortion (seeing), light pollution, and can observe wavelengths (like UV, X-ray, and some infrared) that are blocked or absorbed by Earth's atmosphere. This allows clearer, more detailed observations.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 12,
            question: "What is the significance of the Voyager Golden Records?",
            options: [
                "They contain sounds and images representing Earth, intended for potential extraterrestrial civilizations",
                "They are navigation tools",
                "They store scientific data",
                "They are communication devices"
            ],
            correctAnswer: 0,
            explanation: "The Voyager Golden Records are phonograph records attached to Voyager 1 and 2, containing sounds, music, and images representing Earth and humanity. They serve as a message to any potential extraterrestrial civilizations that might encounter the spacecraft.",
            topic: "Space Exploration"
        ),
        QuizQuestion(
            id: 13,
            question: "What is the main challenge of human missions to Mars compared to the Moon?",
            options: [
                "Distance, travel time, radiation exposure, and need for life support systems",
                "Mars is smaller",
                "Mars has no atmosphere",
                "Mars is colder"
            ],
            correctAnswer: 0,
            explanation: "Mars missions face challenges: much greater distance (months vs. days), prolonged radiation exposure, need for advanced life support systems, psychological effects of isolation, and the need for reliable propulsion and landing systems for the return journey.",
            topic: "Space Exploration"
        )
    ]
}


