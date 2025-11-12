import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface GalaxiesLessonProps {
  onNavigate: (section: string) => void;
}

export function GalaxiesLesson({ onNavigate }: GalaxiesLessonProps) {
  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <Button variant="ghost" onClick={() => onNavigate('study')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Topics
        </Button>
        <Button onClick={() => onNavigate('quiz-galaxies')}>
          Take Quiz
          <ArrowRight className="ml-2 h-4 w-4" />
        </Button>
      </div>

      <div className="space-y-6">
        <div>
          <h1>Galaxies</h1>
          <p className="text-muted-foreground mt-2">
            Explore the massive collections of stars, gas, dust, and dark matter that make up the universe.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>What is a Galaxy?</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1543722530-d2c3201371e7?w=800"
              alt="Spiral galaxy"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              A galaxy is a gravitationally bound system of stars, stellar remnants, interstellar gas,
              dust, and dark matter. The universe contains billions of galaxies, each containing
              millions to trillions of stars.
            </p>
            <p>
              Galaxies range in size from dwarfs with just a few billion stars to giants with one
              hundred trillion stars. They are held together by gravity and often interact with
              neighboring galaxies.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Types of Galaxies</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <div>
              <h4>Spiral Galaxies</h4>
              <p className="text-muted-foreground">
                Characterized by rotating disk with spiral arms extending from a central bulge.
                Our Milky Way is a spiral galaxy.
              </p>
              <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                <li>Rotating disk structure with spiral arms</li>
                <li>Contains younger, blue stars in arms</li>
                <li>Active star formation in spiral arms</li>
                <li>Examples: Milky Way, Andromeda</li>
              </ul>
            </div>

            <div>
              <h4>Elliptical Galaxies</h4>
              <p className="text-muted-foreground">
                Range from nearly spherical to highly elongated shapes. Contain older stars
                and little gas/dust for new star formation.
              </p>
              <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                <li>Smooth, featureless appearance</li>
                <li>Mostly older, red stars</li>
                <li>Little active star formation</li>
                <li>Range from dwarf to giant sizes</li>
              </ul>
            </div>

            <div>
              <h4>Irregular Galaxies</h4>
              <p className="text-muted-foreground">
                Lack distinct shape or structure, often result of gravitational interactions
                or collisions.
              </p>
              <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                <li>No clear structure</li>
                <li>Often result of collisions</li>
                <li>Active star formation</li>
                <li>Examples: Large and Small Magellanic Clouds</li>
              </ul>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Milky Way Galaxy</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Our home galaxy, the Milky Way, is a barred spiral galaxy containing 200-400 billion
              stars. Our Solar System is located in one of the spiral arms, about 27,000 light-years
              from the galactic center.
            </p>
            <div className="grid md:grid-cols-2 gap-4 mt-4">
              <div>
                <h4>Structure</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Diameter: ~100,000 light-years</li>
                  <li>Thickness: ~1,000 light-years</li>
                  <li>Contains central bar structure</li>
                  <li>Multiple spiral arms</li>
                </ul>
              </div>
              <div>
                <h4>Components</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Galactic bulge (central region)</li>
                  <li>Galactic disk (spiral arms)</li>
                  <li>Galactic halo (spherical region)</li>
                  <li>Supermassive black hole at center</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Galactic Collisions</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Galaxies can collide and merge with each other over billions of years. Despite the
              enormous number of stars, actual stellar collisions are rare due to the vast distances
              between stars.
            </p>
            <div className="bg-muted/50 p-4 rounded-lg mt-4">
              <strong>Milky Way-Andromeda Collision</strong>
              <p className="text-muted-foreground mt-2">
                Our Milky Way and the Andromeda Galaxy are on a collision course and will merge
                in about 4.5 billion years, forming a giant elliptical galaxy sometimes called
                "Milkomeda."
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Active Galactic Nuclei (AGN)</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Some galaxies have extremely bright centers powered by supermassive black holes
              actively consuming matter. These can outshine the entire rest of the galaxy.
            </p>
            <div className="space-y-3">
              <div>
                <h4>Quasars</h4>
                <p className="text-muted-foreground">
                  The most luminous objects in the universe, powered by supermassive black holes
                  consuming vast amounts of matter. Most quasars existed in the early universe.
                </p>
              </div>
              <div>
                <h4>Seyfert Galaxies</h4>
                <p className="text-muted-foreground">
                  Spiral galaxies with very bright nuclei, moderate AGN activity.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Local Group</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              The Milky Way is part of a galaxy group called the Local Group, containing over 50
              galaxies within about 10 million light-years.
            </p>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4">
              <div className="border rounded-lg p-3">
                <strong>Milky Way</strong>
                <p className="text-muted-foreground">Our home galaxy</p>
              </div>
              <div className="border rounded-lg p-3">
                <strong>Andromeda (M31)</strong>
                <p className="text-muted-foreground">Largest in Local Group</p>
              </div>
              <div className="border rounded-lg p-3">
                <strong>Triangulum (M33)</strong>
                <p className="text-muted-foreground">Third largest</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Galaxy Clusters and Superclusters</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Galaxies aren't distributed randomly - they're organized into larger structures.
            </p>
            <div className="space-y-3">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Galaxy Clusters:</strong> Groups of hundreds to thousands of galaxies
                  bound by gravity
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Superclusters:</strong> Massive structures containing many galaxy clusters
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Cosmic Web:</strong> The largest-scale structure, with filaments of galaxies
                  separated by vast voids
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-stars')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Stars
          </Button>
          <Button onClick={() => onNavigate('lesson-cosmology')}>
            Next: Cosmology
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
