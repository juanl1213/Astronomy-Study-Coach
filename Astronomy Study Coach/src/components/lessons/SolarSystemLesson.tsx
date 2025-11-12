import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface SolarSystemLessonProps {
  onNavigate: (section: string) => void;
}

export function SolarSystemLesson({ onNavigate }: SolarSystemLessonProps) {
  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <Button variant="ghost" onClick={() => onNavigate('study')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Topics
        </Button>
        <Button onClick={() => onNavigate('quiz-solar-system')}>
          Take Quiz
          <ArrowRight className="ml-2 h-4 w-4" />
        </Button>
      </div>

      <div className="space-y-6">
        <div>
          <h1>The Solar System</h1>
          <p className="text-muted-foreground mt-2">
            Explore our cosmic neighborhood and learn about the Sun and its planetary family.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Overview</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1614732414444-096e5f1122d5?w=800"
              alt="Solar System"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              The Solar System is a gravitationally bound system consisting of the Sun and the objects
              that orbit it. It formed approximately 4.6 billion years ago from the gravitational collapse
              of a giant molecular cloud.
            </p>
            <p>
              Our Solar System consists of the Sun, eight planets, dwarf planets, moons, asteroids,
              comets, and other celestial objects. The four inner planets (Mercury, Venus, Earth, and Mars)
              are terrestrial planets, while the four outer planets (Jupiter, Saturn, Uranus, and Neptune)
              are gas and ice giants.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Sun</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              The Sun is a G-type main-sequence star (G2V) that contains 99.86% of the Solar System's mass.
              It's primarily composed of hydrogen (73%) and helium (25%), with trace amounts of heavier elements.
            </p>
            <ul className="list-disc list-inside space-y-2 text-muted-foreground">
              <li>Diameter: approximately 1.4 million kilometers</li>
              <li>Surface temperature: about 5,500°C (9,932°F)</li>
              <li>Core temperature: approximately 15 million°C</li>
              <li>Age: about 4.6 billion years old</li>
              <li>Expected lifespan: approximately 10 billion years total</li>
            </ul>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Planets</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-4">
              <div>
                <h4>Inner (Terrestrial) Planets</h4>
                <p className="text-muted-foreground">
                  Rocky planets with solid surfaces located closer to the Sun.
                </p>
                <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                  <li><strong>Mercury:</strong> Smallest planet, extreme temperature variations</li>
                  <li><strong>Venus:</strong> Hottest planet due to runaway greenhouse effect</li>
                  <li><strong>Earth:</strong> Only known planet with life</li>
                  <li><strong>Mars:</strong> The Red Planet, has the largest volcano in the Solar System</li>
                </ul>
              </div>

              <div>
                <h4>Outer (Gas and Ice Giants)</h4>
                <p className="text-muted-foreground">
                  Large planets composed primarily of gases and ices.
                </p>
                <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                  <li><strong>Jupiter:</strong> Largest planet, has a Great Red Spot storm</li>
                  <li><strong>Saturn:</strong> Famous for its extensive ring system</li>
                  <li><strong>Uranus:</strong> Tilted on its side, rotates at a 98° angle</li>
                  <li><strong>Neptune:</strong> Furthest planet, has the fastest winds in the Solar System</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Other Celestial Objects</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Dwarf Planets</h4>
                <p className="text-muted-foreground">
                  Celestial bodies that orbit the Sun and have sufficient mass to be round but haven't
                  cleared their orbital path. Examples include Pluto, Eris, Ceres, Makemake, and Haumea.
                </p>
              </div>
              <div>
                <h4>Asteroids</h4>
                <p className="text-muted-foreground">
                  Rocky objects smaller than planets, primarily found in the asteroid belt between
                  Mars and Jupiter. Millions of asteroids exist in our Solar System.
                </p>
              </div>
              <div>
                <h4>Comets</h4>
                <p className="text-muted-foreground">
                  Icy bodies that develop tails when approaching the Sun. They originate from the
                  Kuiper Belt and Oort Cloud in the outer Solar System.
                </p>
              </div>
              <div>
                <h4>Moons</h4>
                <p className="text-muted-foreground">
                  Natural satellites orbiting planets. Our Solar System has over 200 known moons,
                  with Jupiter and Saturn having the most.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Key Concepts</CardTitle>
          </CardHeader>
          <CardContent>
            <ul className="space-y-2">
              <li className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <span><strong>Orbital Period:</strong> The time it takes for an object to complete one orbit around the Sun</span>
              </li>
              <li className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <span><strong>Astronomical Unit (AU):</strong> The average distance from Earth to the Sun (about 150 million km)</span>
              </li>
              <li className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <span><strong>Ecliptic Plane:</strong> The plane of Earth's orbit around the Sun</span>
              </li>
              <li className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <span><strong>Gravity:</strong> The force that holds the Solar System together</span>
              </li>
            </ul>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('study')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Back to Topics
          </Button>
          <Button onClick={() => onNavigate('lesson-planets')}>
            Next: Planets in Detail
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
