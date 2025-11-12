import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface ExoplanetsLessonProps {
  onNavigate: (section: string) => void;
}

export function ExoplanetsLesson({ onNavigate }: ExoplanetsLessonProps) {
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
          <h1>Exoplanets</h1>
          <p className="text-muted-foreground mt-2">
            Discover planets beyond our Solar System and the search for habitable worlds.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>What Are Exoplanets?</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=800"
              alt="Exoplanet concept"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              Exoplanets, or extrasolar planets, are planets that orbit stars other than our Sun.
              The first confirmed exoplanet discovery around a sun-like star was made in 1995.
              Since then, thousands have been discovered.
            </p>
            <div className="bg-muted/50 p-4 rounded-lg">
              <strong>Current Statistics</strong>
              <p className="text-muted-foreground mt-2">
                Over 5,000 confirmed exoplanets have been discovered, with thousands more candidates
                waiting for confirmation. New discoveries are made regularly.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Detection Methods</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>Transit Method</h4>
              <p className="text-muted-foreground">
                Observing the slight dimming of a star's light when a planet passes in front of it.
                This is the most successful method, used by the Kepler and TESS missions.
              </p>
            </div>
            <div>
              <h4>Radial Velocity Method</h4>
              <p className="text-muted-foreground">
                Detecting the wobble in a star's motion caused by the gravitational pull of orbiting
                planets. The first exoplanet around a sun-like star was found using this method.
              </p>
            </div>
            <div>
              <h4>Direct Imaging</h4>
              <p className="text-muted-foreground">
                Actually photographing planets directly. This is challenging because planets are
                much dimmer than their host stars, but technology is improving.
              </p>
            </div>
            <div>
              <h4>Gravitational Microlensing</h4>
              <p className="text-muted-foreground">
                Using gravitational lensing effects when a star-planet system passes in front of
                a background star, briefly magnifying its light.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Types of Exoplanets</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-4">
              <div className="border rounded-lg p-4">
                <h4>Hot Jupiters</h4>
                <p className="text-muted-foreground">
                  Gas giants that orbit very close to their stars, completing orbits in just days.
                  They have extremely high surface temperatures.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Super-Earths</h4>
                <p className="text-muted-foreground">
                  Rocky planets larger than Earth but smaller than Neptune. Many are located in
                  their star's habitable zone.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Mini-Neptunes</h4>
                <p className="text-muted-foreground">
                  Planets smaller than Neptune but larger than Earth, likely with thick atmospheres
                  of hydrogen and helium.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Earth-like Planets</h4>
                <p className="text-muted-foreground">
                  Rocky planets similar in size to Earth, especially those in the habitable zone.
                  These are key targets in the search for life.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Habitable Zone</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              The habitable zone (or "Goldilocks zone") is the region around a star where
              conditions might be right for liquid water to exist on a planet's surface.
            </p>
            <div className="space-y-2 mt-4">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Too Close:</strong> Too hot, water evaporates
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Just Right:</strong> Temperatures allow liquid water
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Too Far:</strong> Too cold, water freezes
                </div>
              </div>
            </div>
            <p className="text-muted-foreground mt-4">
              The location and size of the habitable zone depends on the star's temperature and
              luminosity. Cooler stars have closer habitable zones, while hotter stars have more
              distant ones.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Notable Exoplanet Discoveries</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="border-l-4 border-primary pl-4">
              <h4>TRAPPIST-1 System</h4>
              <p className="text-muted-foreground">
                Seven Earth-sized planets, three in the habitable zone, orbiting an ultra-cool
                dwarf star 40 light-years away.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>Proxima Centauri b</h4>
              <p className="text-muted-foreground">
                An Earth-sized planet in the habitable zone of our nearest stellar neighbor,
                just 4.24 light-years away.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>Kepler-452b</h4>
              <p className="text-muted-foreground">
                Called "Earth's cousin," this super-Earth orbits in the habitable zone of a
                sun-like star.
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <h4>51 Pegasi b</h4>
              <p className="text-muted-foreground">
                The first exoplanet discovered around a sun-like star (1995). A hot Jupiter
                that revolutionized our understanding of planetary systems.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Exoplanet Atmospheres</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Scientists can study exoplanet atmospheres by analyzing starlight that passes through
              or reflects off them. This reveals the chemical composition.
            </p>
            <div className="space-y-2 mt-4">
              <h4>What We Look For</h4>
              <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                <li>Water vapor - essential for life as we know it</li>
                <li>Oxygen and methane - potential biosignatures</li>
                <li>Carbon dioxide - greenhouse gas, climate indicator</li>
                <li>Other molecules that might indicate biological processes</li>
              </ul>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Search for Life</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              The discovery of exoplanets has revolutionized the search for extraterrestrial life.
              Scientists look for biosignatures - indicators that life might be present.
            </p>
            <div className="bg-muted/50 p-4 rounded-lg">
              <h4>Future Missions</h4>
              <p className="text-muted-foreground mt-2">
                The James Webb Space Telescope can analyze exoplanet atmospheres in unprecedented
                detail. Future missions like the Habitable Worlds Observatory will specifically
                target potentially habitable planets.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Exoplanet Statistics</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              <div className="text-center p-4 bg-muted/50 rounded-lg">
                <div className="text-primary">5,000+</div>
                <div className="text-muted-foreground">Confirmed Exoplanets</div>
              </div>
              <div className="text-center p-4 bg-muted/50 rounded-lg">
                <div className="text-primary">3,000+</div>
                <div className="text-muted-foreground">Planetary Systems</div>
              </div>
              <div className="text-center p-4 bg-muted/50 rounded-lg">
                <div className="text-primary">800+</div>
                <div className="text-muted-foreground">Multi-planet Systems</div>
              </div>
              <div className="text-center p-4 bg-muted/50 rounded-lg">
                <div className="text-primary">200+</div>
                <div className="text-muted-foreground">In Habitable Zone</div>
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-cosmology')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Cosmology
          </Button>
          <Button onClick={() => onNavigate('lesson-black-holes')}>
            Next: Black Holes
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
