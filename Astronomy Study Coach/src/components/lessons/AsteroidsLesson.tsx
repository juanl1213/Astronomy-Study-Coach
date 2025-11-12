import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface AsteroidsLessonProps {
  onNavigate: (section: string) => void;
}

export function AsteroidsLesson({ onNavigate }: AsteroidsLessonProps) {
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
          <h1>Asteroids & Comets</h1>
          <p className="text-muted-foreground mt-2">
            Learn about the rocky and icy remnants from the Solar System's formation.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Asteroids</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=800"
              alt="Asteroid"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              Asteroids are rocky, airless remnants left over from the early formation of our Solar
              System about 4.6 billion years ago. Most orbit the Sun in the asteroid belt between
              Mars and Jupiter.
            </p>
            <div className="grid md:grid-cols-2 gap-4 mt-4">
              <div>
                <h4>Composition</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Rocky minerals and metals</li>
                  <li>No atmosphere</li>
                  <li>Irregular shapes</li>
                  <li>Various sizes from pebbles to hundreds of km</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Millions exist in asteroid belt</li>
                  <li>Leftover planetary building blocks</li>
                  <li>Some orbit near Earth (NEAs)</li>
                  <li>Can have their own moons</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Types of Asteroids</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-4">
              <div>
                <h4>C-type (Carbonaceous)</h4>
                <p className="text-muted-foreground">
                  Most common type (~75%). Dark in color, made of clay and silicate rocks. Found
                  in the outer asteroid belt.
                </p>
              </div>
              <div>
                <h4>S-type (Silicaceous)</h4>
                <p className="text-muted-foreground">
                  Second most common (~17%). Made of silicate materials and nickel-iron. Found
                  in the inner asteroid belt.
                </p>
              </div>
              <div>
                <h4>M-type (Metallic)</h4>
                <p className="text-muted-foreground">
                  Made mostly of metallic iron. Thought to be fragments of cores from early
                  planetesimals that broke apart.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Asteroid Belt</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              The asteroid belt is a torus-shaped region between the orbits of Mars and Jupiter,
              containing millions of asteroids.
            </p>
            <div className="bg-muted/50 p-4 rounded-lg">
              <strong>Important Notes:</strong>
              <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                <li>Despite movies, asteroids are very spread out</li>
                <li>Total mass is less than our Moon</li>
                <li>Spacecraft can easily navigate through it</li>
                <li>Contains dwarf planet Ceres</li>
              </ul>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Famous Asteroids</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="border-l-4 border-primary pl-4">
              <h4>Ceres</h4>
              <p className="text-muted-foreground">
                Largest object in the asteroid belt, now classified as a dwarf planet. About 940
                km in diameter. Has ice and possibly an ocean beneath its surface.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>Vesta</h4>
              <p className="text-muted-foreground">
                Second-largest asteroid, about 525 km in diameter. Has a complex geological
                history and a giant impact crater.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>Bennu</h4>
              <p className="text-muted-foreground">
                Near-Earth asteroid visited by NASA's OSIRIS-REx mission. Samples returned to
                Earth in 2023.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>Apophis</h4>
              <p className="text-muted-foreground">
                Near-Earth asteroid that will make a very close approach to Earth in 2029,
                passing within 31,000 km.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Comets</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=800"
              alt="Comet"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              Comets are icy bodies that release gas and dust, forming spectacular tails when they
              approach the Sun. They're often called "dirty snowballs" or "icy dirtballs."
            </p>
            <div className="space-y-3 mt-4">
              <div>
                <h4>Structure of a Comet</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li><strong>Nucleus:</strong> Solid core of ice, rock, and dust (few km across)</li>
                  <li><strong>Coma:</strong> Cloud of gas and dust around nucleus</li>
                  <li><strong>Dust Tail:</strong> Dust pushed away by solar radiation (curves)</li>
                  <li><strong>Ion Tail:</strong> Ionized gas pushed by solar wind (straight, points away from Sun)</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Comet Origins</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>Kuiper Belt</h4>
              <p className="text-muted-foreground">
                Region beyond Neptune (30-50 AU) containing icy bodies. Short-period comets
                (orbital periods less than 200 years) originate here.
              </p>
            </div>
            <div>
              <h4>Oort Cloud</h4>
              <p className="text-muted-foreground">
                Theoretical cloud of icy bodies surrounding the Solar System at 50,000-100,000 AU.
                Long-period comets originate here. May contain trillions of comets.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Famous Comets</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="border-l-4 border-primary pl-4">
              <h4>Halley's Comet</h4>
              <p className="text-muted-foreground">
                Most famous comet, returns every 75-76 years. Last visited inner Solar System in
                1986, will return in 2061. Visible to naked eye.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>Comet Hale-Bopp</h4>
              <p className="text-muted-foreground">
                Spectacular comet visible to naked eye for 18 months in 1996-1997. Won't return
                for about 2,500 years.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>Comet NEOWISE</h4>
              <p className="text-muted-foreground">
                Discovered in 2020, became visible to naked eye. Next return in about 6,800 years.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Meteors and Meteorites</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-3">
              <div>
                <h4>Meteoroids</h4>
                <p className="text-muted-foreground">
                  Small rocks or particles in space, often debris from comets or asteroids.
                </p>
              </div>
              <div>
                <h4>Meteors ("Shooting Stars")</h4>
                <p className="text-muted-foreground">
                  Meteoroids burning up in Earth's atmosphere, creating bright streaks of light.
                  Most burn up completely.
                </p>
              </div>
              <div>
                <h4>Meteorites</h4>
                <p className="text-muted-foreground">
                  Meteoroids that survive passage through the atmosphere and land on Earth's surface.
                  Valuable for studying Solar System formation.
                </p>
              </div>
              <div>
                <h4>Meteor Showers</h4>
                <p className="text-muted-foreground">
                  When Earth passes through debris trails left by comets. Examples: Perseids (August),
                  Geminids (December), Leonids (November).
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Asteroid and Comet Missions</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="border rounded-lg p-3">
              <strong>OSIRIS-REx (NASA)</strong>
              <p className="text-muted-foreground">
                Collected samples from asteroid Bennu, returned to Earth in 2023.
              </p>
            </div>
            <div className="border rounded-lg p-3">
              <strong>Rosetta (ESA)</strong>
              <p className="text-muted-foreground">
                Orbited comet 67P, deployed lander Philae to surface in 2014.
              </p>
            </div>
            <div className="border rounded-lg p-3">
              <strong>DART (NASA)</strong>
              <p className="text-muted-foreground">
                Successfully changed the orbit of asteroid Dimorphos in 2022, testing planetary
                defense.
              </p>
            </div>
            <div className="border rounded-lg p-3">
              <strong>Dawn (NASA)</strong>
              <p className="text-muted-foreground">
                Orbited both Vesta and Ceres, first mission to orbit two extraterrestrial bodies.
              </p>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-nebulae')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Nebulae
          </Button>
          <Button onClick={() => onNavigate('lesson-space-exploration')}>
            Next: Space Exploration
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
