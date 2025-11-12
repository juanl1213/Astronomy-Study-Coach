import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface BlackHolesLessonProps {
  onNavigate: (section: string) => void;
}

export function BlackHolesLesson({ onNavigate }: BlackHolesLessonProps) {
  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <Button variant="ghost" onClick={() => onNavigate('study')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Topics
        </Button>
        <Button onClick={() => onNavigate('quiz-general')}>
          Take Quiz
          <ArrowRight className="ml-2 h-4 w-4" />
        </Button>
      </div>

      <div className="space-y-6">
        <div>
          <h1>Black Holes</h1>
          <p className="text-muted-foreground mt-2">
            Explore the most extreme objects in the universe where gravity is so strong that nothing can escape.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>What is a Black Hole?</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1510266152-c97b0c5db89e?w=800"
              alt="Black hole visualization"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              A black hole is a region of spacetime where gravity is so strong that nothing—not even
              light—can escape from it. The boundary of this region is called the event horizon.
            </p>
            <p>
              Despite their name, black holes aren't actually "holes" in space. They're extremely dense
              objects with mass compressed into a very small area, creating immensely powerful gravity.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>How Black Holes Form</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>Stellar Black Holes</h4>
              <p className="text-muted-foreground">
                When a massive star (at least 20 times the mass of the Sun) runs out of fuel,
                it can no longer support itself against gravity. The core collapses in a supernova
                explosion, and if enough mass remains, it forms a black hole.
              </p>
              <div className="mt-3 space-y-2">
                <div className="flex items-start">
                  <span className="text-primary mr-2">1.</span>
                  <div>Massive star exhausts its nuclear fuel</div>
                </div>
                <div className="flex items-start">
                  <span className="text-primary mr-2">2.</span>
                  <div>Core collapses under its own gravity</div>
                </div>
                <div className="flex items-start">
                  <span className="text-primary mr-2">3.</span>
                  <div>Supernova explosion blows off outer layers</div>
                </div>
                <div className="flex items-start">
                  <span className="text-primary mr-2">4.</span>
                  <div>Remaining core collapses to a point (singularity)</div>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Types of Black Holes</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-4">
              <div className="border rounded-lg p-4">
                <h4>Stellar Black Holes</h4>
                <p className="text-muted-foreground">
                  Formed from collapsed stars. Mass: 5-100 times the Sun's mass. Most common type
                  in our galaxy.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Intermediate Black Holes</h4>
                <p className="text-muted-foreground">
                  Rare and still being studied. Mass: 100-100,000 solar masses. May form from
                  mergers of smaller black holes.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Supermassive Black Holes</h4>
                <p className="text-muted-foreground">
                  Found at the centers of most galaxies. Mass: millions to billions of solar masses.
                  Our galaxy has one called Sagittarius A*.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Primordial Black Holes (Theoretical)</h4>
                <p className="text-muted-foreground">
                  Hypothetical black holes formed in the early universe. If they exist, could
                  range from tiny to large masses.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Anatomy of a Black Hole</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-3">
              <div>
                <h4>Singularity</h4>
                <p className="text-muted-foreground">
                  The point at the center where all the mass is concentrated. Here, density becomes
                  infinite and our current laws of physics break down.
                </p>
              </div>
              <div>
                <h4>Event Horizon</h4>
                <p className="text-muted-foreground">
                  The "point of no return." Once anything crosses this boundary, it cannot escape,
                  not even light. The size of the event horizon (Schwarzschild radius) depends on
                  the black hole's mass.
                </p>
              </div>
              <div>
                <h4>Accretion Disk</h4>
                <p className="text-muted-foreground">
                  Matter spiraling into a black hole forms a disk. Friction heats this matter to
                  millions of degrees, making it glow brightly in X-rays—one way we detect black holes.
                </p>
              </div>
              <div>
                <h4>Relativistic Jets</h4>
                <p className="text-muted-foreground">
                  Some black holes shoot out powerful jets of particles at nearly the speed of light,
                  perpendicular to the accretion disk.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Effects on Space and Time</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>Gravitational Time Dilation</h4>
              <p className="text-muted-foreground">
                Time passes more slowly near a black hole due to extreme gravity. An observer near
                a black hole would age more slowly than someone far away.
              </p>
            </div>
            <div>
              <h4>Spaghettification</h4>
              <p className="text-muted-foreground">
                Objects falling into a black hole experience extreme tidal forces. The difference
                in gravity between the near and far side stretches objects into long, thin shapes
                like spaghetti.
              </p>
            </div>
            <div>
              <h4>Gravitational Lensing</h4>
              <p className="text-muted-foreground">
                A black hole's gravity bends light passing near it, distorting and magnifying
                background objects. This helped capture the first black hole image.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>First Image of a Black Hole</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              In April 2019, the Event Horizon Telescope collaboration revealed the first-ever image
              of a black hole's event horizon. The target was M87*, a supermassive black hole in the
              galaxy M87, 55 million light-years away.
            </p>
            <div className="bg-muted/50 p-4 rounded-lg">
              <strong>M87* Facts</strong>
              <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                <li>Mass: 6.5 billion times the Sun's mass</li>
                <li>Size: Larger than our entire Solar System</li>
                <li>The bright ring shows glowing gas orbiting the black hole</li>
                <li>The dark center is the "shadow" of the event horizon</li>
              </ul>
            </div>
            <p className="text-muted-foreground mt-4">
              In 2022, the same team released an image of Sagittarius A*, the supermassive black
              hole at the center of our own Milky Way galaxy.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Hawking Radiation</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Stephen Hawking theorized that black holes aren't completely black. Due to quantum
              effects near the event horizon, they emit tiny amounts of radiation.
            </p>
            <div className="space-y-2 mt-4">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  Over extremely long timescales, black holes can slowly evaporate
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  Smaller black holes evaporate faster than large ones
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  For stellar-mass black holes, evaporation takes longer than the current age of the universe
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Detecting Black Holes</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Since black holes don't emit light, we detect them through their effects:
            </p>
            <div className="space-y-2">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>X-ray emissions:</strong> From superheated accretion disks
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Gravitational effects:</strong> On nearby stars and gas
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Gravitational waves:</strong> From merging black holes
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Gravitational lensing:</strong> Bending of background light
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Famous Black Holes</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="border-l-4 border-primary pl-4">
              <h4>Sagittarius A*</h4>
              <p className="text-muted-foreground">
                The supermassive black hole at our galaxy's center, 4 million solar masses,
                26,000 light-years away.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>Cygnus X-1</h4>
              <p className="text-muted-foreground">
                First black hole candidate discovered (1964), confirmed in the 1990s. About 15
                solar masses, 6,000 light-years away.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>TON 618</h4>
              <p className="text-muted-foreground">
                One of the most massive black holes known, with an estimated 66 billion solar masses.
              </p>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-exoplanets')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Exoplanets
          </Button>
          <Button onClick={() => onNavigate('lesson-nebulae')}>
            Next: Nebulae
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
