import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface NebulaeLessonProps {
  onNavigate: (section: string) => void;
}

export function NebulaeLesson({ onNavigate }: NebulaeLessonProps) {
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
          <h1>Nebulae</h1>
          <p className="text-muted-foreground mt-2">
            Discover the beautiful clouds of gas and dust where stars are born and die.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>What Are Nebulae?</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1502134249126-9f3755a50d78?w=800"
              alt="Nebula"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              Nebulae (singular: nebula) are vast clouds of dust and gas in space. They're some of
              the most visually stunning objects in the universe, often glowing with brilliant colors.
            </p>
            <p>
              The word "nebula" comes from the Latin word for "cloud." These cosmic clouds can span
              hundreds of light-years and serve as both stellar nurseries and stellar graveyards.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Types of Nebulae</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <div>
              <h4>Emission Nebulae</h4>
              <p className="text-muted-foreground">
                Clouds of ionized gas that emit light of various colors. Nearby hot stars provide
                energy that causes the gas to glow. Often appear red due to hydrogen emission.
              </p>
              <div className="bg-muted/50 p-3 rounded-lg mt-2">
                <strong>Example:</strong> Orion Nebula (M42)
              </div>
            </div>

            <div>
              <h4>Reflection Nebulae</h4>
              <p className="text-muted-foreground">
                Clouds of dust that reflect light from nearby stars. Usually appear blue because
                blue light scatters more efficiently than red light.
              </p>
              <div className="bg-muted/50 p-3 rounded-lg mt-2">
                <strong>Example:</strong> Pleiades reflection nebulae
              </div>
            </div>

            <div>
              <h4>Dark Nebulae</h4>
              <p className="text-muted-foreground">
                Dense clouds of dust that block light from objects behind them, appearing as dark
                patches against bright backgrounds.
              </p>
              <div className="bg-muted/50 p-3 rounded-lg mt-2">
                <strong>Example:</strong> Horsehead Nebula
              </div>
            </div>

            <div>
              <h4>Planetary Nebulae</h4>
              <p className="text-muted-foreground">
                Glowing shells of gas ejected by dying sun-like stars. Despite the name, they have
                nothing to do with planets—early astronomers thought they looked planet-like through
                small telescopes.
              </p>
              <div className="bg-muted/50 p-3 rounded-lg mt-2">
                <strong>Example:</strong> Ring Nebula (M57), Cat's Eye Nebula
              </div>
            </div>

            <div>
              <h4>Supernova Remnants</h4>
              <p className="text-muted-foreground">
                Expanding shells of gas from exploded massive stars. These nebulae spread heavy
                elements throughout space.
              </p>
              <div className="bg-muted/50 p-3 rounded-lg mt-2">
                <strong>Example:</strong> Crab Nebula
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Star Formation in Nebulae</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Many nebulae are stellar nurseries where new stars are born. The process takes millions
              of years:
            </p>
            <div className="space-y-2 mt-4">
              <div className="flex items-start">
                <span className="text-primary mr-2">1.</span>
                <div>
                  <strong>Initial Collapse:</strong> Gravity causes denser regions to contract
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">2.</span>
                <div>
                  <strong>Fragmentation:</strong> Large clouds break into smaller clumps
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">3.</span>
                <div>
                  <strong>Heating:</strong> Compression causes temperature to rise
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">4.</span>
                <div>
                  <strong>Protostar Formation:</strong> Dense cores become hot enough to glow
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">5.</span>
                <div>
                  <strong>Nuclear Fusion Begins:</strong> New star ignites and starts shining
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Famous Nebulae</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-4">
              <div className="border rounded-lg p-4">
                <h4>Orion Nebula (M42)</h4>
                <p className="text-muted-foreground">
                  One of the brightest nebulae, visible to the naked eye. Located 1,344 light-years
                  away in the constellation Orion. Active star-forming region.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Eagle Nebula (M16)</h4>
                <p className="text-muted-foreground">
                  Home to the famous "Pillars of Creation" photographed by Hubble. Massive star
                  formation region 7,000 light-years away.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Carina Nebula</h4>
                <p className="text-muted-foreground">
                  One of the largest and brightest nebulae, four times larger than Orion. Contains
                  Eta Carinae, one of the most massive stars known.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Helix Nebula</h4>
                <p className="text-muted-foreground">
                  One of the closest planetary nebulae, about 650 light-years away. Often called
                  the "Eye of God" due to its appearance.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Crab Nebula (M1)</h4>
                <p className="text-muted-foreground">
                  Supernova remnant from an explosion observed by Chinese astronomers in 1054 AD.
                  Contains a pulsar spinning 30 times per second.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Nebula Colors</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              The beautiful colors of nebulae come from different glowing gases:
            </p>
            <div className="space-y-3 mt-4">
              <div className="flex items-center gap-3">
                <div className="w-12 h-12 rounded bg-red-500/20 border-2 border-red-500"></div>
                <div>
                  <strong>Red:</strong>
                  <span className="text-muted-foreground ml-2">Hydrogen emission</span>
                </div>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-12 h-12 rounded bg-green-500/20 border-2 border-green-500"></div>
                <div>
                  <strong>Green:</strong>
                  <span className="text-muted-foreground ml-2">Oxygen emission</span>
                </div>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-12 h-12 rounded bg-blue-500/20 border-2 border-blue-500"></div>
                <div>
                  <strong>Blue:</strong>
                  <span className="text-muted-foreground ml-2">Helium or reflected starlight</span>
                </div>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-12 h-12 rounded bg-yellow-500/20 border-2 border-yellow-500"></div>
                <div>
                  <strong>Yellow:</strong>
                  <span className="text-muted-foreground ml-2">Sulfur emission</span>
                </div>
              </div>
            </div>
            <p className="text-muted-foreground mt-4">
              Note: Many nebula images use false colors to highlight different elements and structures.
              Our eyes can't see all these colors directly.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Pillars of Creation</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Perhaps the most iconic image from the Hubble Space Telescope, the Pillars of Creation
              are part of the Eagle Nebula.
            </p>
            <div className="space-y-2">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>Column-like structures of gas and dust</div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>Several light-years tall</div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>New stars forming inside the dense clouds</div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>Being eroded by radiation from nearby young stars</div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Observing Nebulae</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>With the Naked Eye</h4>
              <p className="text-muted-foreground">
                A few bright nebulae can be seen without a telescope, including the Orion Nebula
                and the Lagoon Nebula, though they appear as faint fuzzy patches.
              </p>
            </div>
            <div>
              <h4>Through Telescopes</h4>
              <p className="text-muted-foreground">
                Even small telescopes reveal more detail. Larger telescopes and long-exposure
                photography reveal the stunning colors and structures.
              </p>
            </div>
            <div>
              <h4>Best Viewing Tips</h4>
              <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                <li>Get away from light pollution</li>
                <li>Allow eyes to dark-adapt for 20-30 minutes</li>
                <li>Use averted vision (look slightly to the side)</li>
                <li>Winter months are best for many bright nebulae</li>
              </ul>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-black-holes')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Black Holes
          </Button>
          <Button onClick={() => onNavigate('lesson-asteroids')}>
            Next: Asteroids & Comets
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
