import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "./ui/card";
import { Input } from "./ui/input";
import { Button } from "./ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "./ui/tabs";
import { Search, BookOpen } from "lucide-react";

interface GlossaryProps {
  onNavigate: (section: string) => void;
}

export function Glossary({ onNavigate }: GlossaryProps) {
  const [searchTerm, setSearchTerm] = useState("");

  const glossaryTerms = {
    'General': [
      { term: 'Astronomy', definition: 'The scientific study of celestial objects, space, and the universe as a whole.' },
      { term: 'Celestial', definition: 'Relating to the sky or outer space as observed in astronomy.' },
      { term: 'Light-year', definition: 'The distance light travels in one year, approximately 9.46 trillion kilometers.' },
      { term: 'Parsec', definition: 'A unit of distance equal to about 3.26 light-years.' },
      { term: 'Redshift', definition: 'The stretching of light to longer wavelengths as an object moves away from us.' }
    ],
    'Solar System': [
      { term: 'Asteroid', definition: 'A small rocky body orbiting the Sun, most found between Mars and Jupiter.' },
      { term: 'Astronomical Unit (AU)', definition: 'The average distance from Earth to the Sun, about 150 million kilometers.' },
      { term: 'Comet', definition: 'An icy body that releases gas and dust, forming a tail when approaching the Sun.' },
      { term: 'Dwarf Planet', definition: 'A celestial body that orbits the Sun and is spherical but hasn\'t cleared its orbit.' },
      { term: 'Ecliptic', definition: 'The plane of Earth\'s orbit around the Sun.' },
      { term: 'Kuiper Belt', definition: 'Region beyond Neptune containing icy bodies and dwarf planets.' },
      { term: 'Meteoroid', definition: 'A small rock or particle in space.' },
      { term: 'Meteor', definition: 'A meteoroid burning up in Earth\'s atmosphere, also called a shooting star.' },
      { term: 'Meteorite', definition: 'A meteoroid that survives passage through the atmosphere and lands on Earth.' }
    ],
    'Stars': [
      { term: 'Binary Star', definition: 'A system of two stars orbiting their common center of mass.' },
      { term: 'Main Sequence', definition: 'The stable phase of a star\'s life where it fuses hydrogen into helium.' },
      { term: 'Nebula', definition: 'A cloud of gas and dust in space, often a star-forming region.' },
      { term: 'Nuclear Fusion', definition: 'The process of combining atomic nuclei to form heavier elements, releasing energy.' },
      { term: 'Protostar', definition: 'A very young star in the early stages of formation.' },
      { term: 'Red Giant', definition: 'A large, cool star in a late stage of stellar evolution.' },
      { term: 'Supernova', definition: 'A powerful explosion marking the death of a massive star.' },
      { term: 'White Dwarf', definition: 'The hot, dense core remnant of a sun-like star after it has exhausted its fuel.' },
      { term: 'Neutron Star', definition: 'An extremely dense collapsed core of a massive star, composed mostly of neutrons.' },
      { term: 'Pulsar', definition: 'A rapidly rotating neutron star that emits beams of radiation.' }
    ],
    'Galaxies & Cosmology': [
      { term: 'Active Galactic Nucleus (AGN)', definition: 'A region at the center of a galaxy with unusually high luminosity.' },
      { term: 'Big Bang', definition: 'The event that marked the beginning of the universe 13.8 billion years ago.' },
      { term: 'Black Hole', definition: 'A region of spacetime where gravity is so strong that nothing can escape.' },
      { term: 'Dark Energy', definition: 'Mysterious energy causing the universe\'s expansion to accelerate.' },
      { term: 'Dark Matter', definition: 'Invisible matter detected only through its gravitational effects.' },
      { term: 'Event Horizon', definition: 'The boundary of a black hole beyond which nothing can escape.' },
      { term: 'Galaxy', definition: 'A massive system of stars, gas, dust, and dark matter bound by gravity.' },
      { term: 'Galaxy Cluster', definition: 'A group of galaxies bound together by gravity.' },
      { term: 'Quasar', definition: 'An extremely luminous active galactic nucleus powered by a supermassive black hole.' },
      { term: 'Supermassive Black Hole', definition: 'A black hole with millions to billions of solar masses, found at galaxy centers.' }
    ],
    'Observation': [
      { term: 'Apparent Magnitude', definition: 'How bright an object appears from Earth.' },
      { term: 'Constellation', definition: 'A pattern of stars as seen from Earth, used for navigation and identification.' },
      { term: 'Ecliptic', definition: 'The apparent path of the Sun across the sky over the course of a year.' },
      { term: 'Equinox', definition: 'When day and night are approximately equal in length, occurring twice yearly.' },
      { term: 'Light Pollution', definition: 'Excessive artificial light that makes it difficult to observe celestial objects.' },
      { term: 'Solstice', definition: 'When the Sun reaches its highest or lowest point in the sky, occurring twice yearly.' },
      { term: 'Spectrum', definition: 'The range of wavelengths of electromagnetic radiation.' },
      { term: 'Transit', definition: 'The passage of a celestial body across the face of another, larger body.' },
      { term: 'Zenith', definition: 'The point in the sky directly overhead an observer.' }
    ]
  };

  const filterTerms = (terms: typeof glossaryTerms[keyof typeof glossaryTerms]) => {
    if (!searchTerm) return terms;
    return terms.filter(
      (item) =>
        item.term.toLowerCase().includes(searchTerm.toLowerCase()) ||
        item.definition.toLowerCase().includes(searchTerm.toLowerCase())
    );
  };

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div>
        <h1>Astronomy Glossary</h1>
        <p className="text-muted-foreground mt-2">
          Quick reference guide to astronomical terms and concepts.
        </p>
      </div>

      <Card>
        <CardHeader>
          <div className="flex items-center space-x-2">
            <Search className="h-5 w-5 text-muted-foreground" />
            <Input
              placeholder="Search terms..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="flex-1"
            />
          </div>
        </CardHeader>
      </Card>

      <Tabs defaultValue="General" className="w-full">
        <TabsList className="grid w-full grid-cols-5">
          <TabsTrigger value="General">General</TabsTrigger>
          <TabsTrigger value="Solar System">Solar System</TabsTrigger>
          <TabsTrigger value="Stars">Stars</TabsTrigger>
          <TabsTrigger value="Galaxies & Cosmology">Galaxies</TabsTrigger>
          <TabsTrigger value="Observation">Observation</TabsTrigger>
        </TabsList>

        {Object.entries(glossaryTerms).map(([category, terms]) => (
          <TabsContent key={category} value={category} className="space-y-3">
            <div className="flex items-center justify-between mb-4">
              <h3>{category}</h3>
              <span className="text-sm text-muted-foreground">
                {filterTerms(terms).length} terms
              </span>
            </div>
            {filterTerms(terms).length === 0 ? (
              <Card>
                <CardContent className="pt-6 text-center text-muted-foreground">
                  No terms found matching "{searchTerm}"
                </CardContent>
              </Card>
            ) : (
              filterTerms(terms).map((item, index) => (
                <Card key={index}>
                  <CardHeader>
                    <CardTitle className="text-base flex items-center">
                      <BookOpen className="h-4 w-4 mr-2 text-primary" />
                      {item.term}
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <p className="text-muted-foreground">{item.definition}</p>
                  </CardContent>
                </Card>
              ))
            )}
          </TabsContent>
        ))}
      </Tabs>

      <Card>
        <CardContent className="pt-6">
          <div className="text-center space-y-3">
            <p className="text-muted-foreground">
              Want to learn more about these concepts?
            </p>
            <Button onClick={() => onNavigate('study')}>
              <BookOpen className="mr-2 h-4 w-4" />
              Browse Study Topics
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
