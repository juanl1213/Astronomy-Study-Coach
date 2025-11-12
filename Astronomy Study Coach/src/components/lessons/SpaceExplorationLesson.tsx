import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface SpaceExplorationLessonProps {
  onNavigate: (section: string) => void;
}

export function SpaceExplorationLesson({ onNavigate }: SpaceExplorationLessonProps) {
  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <Button variant="ghost" onClick={() => onNavigate('study')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Topics
        </Button>
      </div>

      <div className="space-y-6">
        <div>
          <h1>Space Exploration</h1>
          <p className="text-muted-foreground mt-2">
            Journey through humanity's ventures beyond Earth and our quest to explore the cosmos.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>The Space Age Begins</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?w=800"
              alt="Rocket launch"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              The Space Age began on October 4, 1957, when the Soviet Union launched Sputnik 1,
              the first artificial satellite to orbit Earth. This event marked the start of space
              exploration and the Space Race between the United States and Soviet Union.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Major Milestones</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="border-l-4 border-primary pl-4">
              <strong>1957 - Sputnik 1</strong>
              <p className="text-muted-foreground">First artificial satellite in orbit</p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <strong>1961 - Yuri Gagarin</strong>
              <p className="text-muted-foreground">First human in space</p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <strong>1969 - Apollo 11</strong>
              <p className="text-muted-foreground">
                First humans on the Moon (Neil Armstrong and Buzz Aldrin)
              </p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <strong>1971 - Salyut 1</strong>
              <p className="text-muted-foreground">First space station</p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <strong>1981 - Space Shuttle</strong>
              <p className="text-muted-foreground">First reusable spacecraft</p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <strong>1998 - ISS Construction Begins</strong>
              <p className="text-muted-foreground">International Space Station assembly starts</p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <strong>2012 - Curiosity on Mars</strong>
              <p className="text-muted-foreground">Advanced rover begins exploring Mars</p>
            </div>
            <div className="border-l-4 border-primary pl-4">
              <strong>2020 - Commercial Crew</strong>
              <p className="text-muted-foreground">SpaceX begins regular crewed missions to ISS</p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Robotic Space Exploration</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>Moon Missions</h4>
              <p className="text-muted-foreground">
                From early Luna and Ranger probes to modern missions like Chandrayaan and Artemis,
                robotic spacecraft have mapped the Moon and paved the way for human exploration.
              </p>
            </div>
            <div>
              <h4>Mars Rovers</h4>
              <p className="text-muted-foreground">
                A series of increasingly sophisticated rovers have explored Mars: Sojourner (1997),
                Spirit and Opportunity (2004), Curiosity (2012), and Perseverance (2021).
              </p>
            </div>
            <div>
              <h4>Outer Solar System</h4>
              <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                <li><strong>Voyager 1 & 2:</strong> Explored outer planets, now in interstellar space</li>
                <li><strong>Cassini:</strong> Orbited Saturn for 13 years, studied rings and moons</li>
                <li><strong>Juno:</strong> Currently orbiting Jupiter, studying its atmosphere</li>
                <li><strong>New Horizons:</strong> Flew by Pluto (2015) and Kuiper Belt objects</li>
              </ul>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Space Telescopes</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-4">
              <div>
                <h4>Hubble Space Telescope (1990)</h4>
                <p className="text-muted-foreground">
                  Revolutionary optical telescope that has transformed our understanding of the
                  universe. Still operating after over 30 years, providing stunning images and
                  important scientific data.
                </p>
              </div>
              <div>
                <h4>James Webb Space Telescope (2021)</h4>
                <p className="text-muted-foreground">
                  Most powerful space telescope ever built. Observes in infrared, allowing it to
                  see the first galaxies and study exoplanet atmospheres in detail.
                </p>
              </div>
              <div>
                <h4>Other Notable Telescopes</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li><strong>Chandra:</strong> X-ray astronomy</li>
                  <li><strong>Spitzer:</strong> Infrared observations (retired 2020)</li>
                  <li><strong>Kepler/TESS:</strong> Exoplanet hunters</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Human Spaceflight</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>International Space Station (ISS)</h4>
              <p className="text-muted-foreground">
                Largest structure humans have ever put into space. Continuously inhabited since
                November 2000. Partnership between NASA, Roscosmos, ESA, JAXA, and CSA.
              </p>
              <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                <li>Orbits Earth every 90 minutes</li>
                <li>Travels at 28,000 km/h</li>
                <li>Living space roughly the size of a six-bedroom house</li>
                <li>Hosts continuous scientific research</li>
              </ul>
            </div>
            <div className="mt-4">
              <h4>Commercial Spaceflight</h4>
              <p className="text-muted-foreground">
                Private companies like SpaceX, Blue Origin, and others are making space more
                accessible, launching satellites, cargo, astronauts, and even tourists.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Future of Space Exploration</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-4">
              <div className="border rounded-lg p-4">
                <h4>Artemis Program</h4>
                <p className="text-muted-foreground">
                  NASA's program to return humans to the Moon by the mid-2020s, including the
                  first woman and first person of color. Plans to establish a sustainable presence
                  with a lunar Gateway station.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Mars Exploration</h4>
                <p className="text-muted-foreground">
                  Multiple agencies planning crewed missions to Mars in the 2030s-2040s. Challenges
                  include radiation protection, life support, and the long journey time.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Europa Clipper</h4>
                <p className="text-muted-foreground">
                  NASA mission launching in 2024 to study Jupiter's moon Europa, which may have a
                  subsurface ocean potentially harboring life.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Starship</h4>
                <p className="text-muted-foreground">
                  SpaceX's fully reusable heavy-lift launch system designed for missions to the
                  Moon, Mars, and beyond.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Challenges of Space Exploration</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Radiation:</strong> Cosmic rays and solar radiation are dangerous to astronauts
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Distance:</strong> Vast distances require years of travel time
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Life Support:</strong> Providing air, water, and food for long missions
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Cost:</strong> Space missions are extremely expensive
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Communication Delays:</strong> Signals from Mars take 4-24 minutes one-way
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Microgravity Effects:</strong> Long-term health impacts on astronauts
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Benefits of Space Exploration</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Scientific Discovery:</strong> Understanding our universe and our place in it
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Technology Development:</strong> GPS, weather forecasting, medical devices
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Earth Monitoring:</strong> Climate change, natural disasters, agriculture
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Resource Potential:</strong> Asteroid mining, solar power from space
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Inspiration:</strong> Inspiring future generations of scientists and engineers
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Planetary Protection:</strong> Detecting and deflecting hazardous asteroids
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-start pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-asteroids')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Asteroids & Comets
          </Button>
        </div>
      </div>
    </div>
  );
}
