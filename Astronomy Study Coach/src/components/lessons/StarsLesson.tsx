import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface StarsLessonProps {
  onNavigate: (section: string) => void;
}

export function StarsLesson({ onNavigate }: StarsLessonProps) {
  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <Button variant="ghost" onClick={() => onNavigate('study')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Topics
        </Button>
        <Button onClick={() => onNavigate('quiz-stars')}>
          Take Quiz
          <ArrowRight className="ml-2 h-4 w-4" />
        </Button>
      </div>

      <div className="space-y-6">
        <div>
          <h1>Stars & Stellar Evolution</h1>
          <p className="text-muted-foreground mt-2">
            Discover the life cycles of stars and the processes that power these cosmic furnaces.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>What Are Stars?</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=800"
              alt="Stars in the night sky"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              Stars are massive, luminous spheres of plasma held together by gravity. They generate
              energy through nuclear fusion in their cores, converting hydrogen into helium and
              releasing tremendous amounts of energy in the process.
            </p>
            <p>
              The energy from stars is what makes them shine, providing light and heat to their
              surrounding space. Our Sun is a medium-sized star, and it has been burning for about
              4.6 billion years with billions more years to go.
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Star Formation</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <h4>Nebulae - Stellar Nurseries</h4>
            <p className="text-muted-foreground">
              Stars form in massive clouds of gas and dust called nebulae. The process begins when
              gravity causes regions of the nebula to collapse.
            </p>
            <div className="space-y-2 mt-4">
              <div className="flex items-start">
                <span className="text-primary mr-2">1.</span>
                <div>
                  <strong>Collapse:</strong> Gravity pulls gas and dust together
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">2.</span>
                <div>
                  <strong>Protostar:</strong> Material accumulates and heats up
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">3.</span>
                <div>
                  <strong>Nuclear Fusion:</strong> Core temperature reaches ~10 million°C, fusion begins
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">4.</span>
                <div>
                  <strong>Main Sequence Star:</strong> Star achieves equilibrium and begins its stable life
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Stellar Classification</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Stars are classified by their spectral type, which indicates their surface temperature
              and color. The classification system uses letters: O, B, A, F, G, K, M.
            </p>
            <div className="space-y-3">
              <div className="p-3 bg-blue-500/10 border border-blue-500/20 rounded-lg">
                <strong>O-Type (Blue):</strong>
                <span className="text-muted-foreground ml-2">Hottest stars, 30,000+ K</span>
              </div>
              <div className="p-3 bg-blue-400/10 border border-blue-400/20 rounded-lg">
                <strong>B-Type (Blue-White):</strong>
                <span className="text-muted-foreground ml-2">10,000-30,000 K</span>
              </div>
              <div className="p-3 bg-white/10 border border-white/20 rounded-lg">
                <strong>A-Type (White):</strong>
                <span className="text-muted-foreground ml-2">7,500-10,000 K</span>
              </div>
              <div className="p-3 bg-yellow-200/10 border border-yellow-200/20 rounded-lg">
                <strong>F-Type (Yellow-White):</strong>
                <span className="text-muted-foreground ml-2">6,000-7,500 K</span>
              </div>
              <div className="p-3 bg-yellow-400/10 border border-yellow-400/20 rounded-lg">
                <strong>G-Type (Yellow):</strong>
                <span className="text-muted-foreground ml-2">5,200-6,000 K (Our Sun!)</span>
              </div>
              <div className="p-3 bg-orange-400/10 border border-orange-400/20 rounded-lg">
                <strong>K-Type (Orange):</strong>
                <span className="text-muted-foreground ml-2">3,700-5,200 K</span>
              </div>
              <div className="p-3 bg-red-500/10 border border-red-500/20 rounded-lg">
                <strong>M-Type (Red):</strong>
                <span className="text-muted-foreground ml-2">Coolest stars, 2,400-3,700 K</span>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Life Cycle of Stars</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <h4>Low to Medium Mass Stars (like our Sun)</h4>
            <div className="space-y-2">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Main Sequence:</strong> Stable hydrogen fusion (billions of years)
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Red Giant:</strong> Expands when hydrogen depleted, fuses helium
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Planetary Nebula:</strong> Outer layers expelled into space
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>White Dwarf:</strong> Dense core remnant, slowly cooling
                </div>
              </div>
            </div>

            <h4 className="mt-6">High Mass Stars</h4>
            <div className="space-y-2">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Main Sequence:</strong> Burns through fuel much faster
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Supergiant:</strong> Massive expansion, fusion of heavier elements
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Supernova:</strong> Catastrophic explosion
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Neutron Star or Black Hole:</strong> Ultra-dense remnant
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Nuclear Fusion in Stars</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Nuclear fusion is the process that powers stars. In the extreme temperature and
              pressure of a star's core, hydrogen nuclei (protons) fuse together to form helium,
              releasing enormous amounts of energy.
            </p>
            <div className="bg-muted/50 p-4 rounded-lg">
              <strong>The Proton-Proton Chain (in Sun-like stars):</strong>
              <p className="text-muted-foreground mt-2">
                4 Hydrogen nuclei → 1 Helium nucleus + energy (photons and neutrinos)
              </p>
              <p className="text-muted-foreground mt-2">
                This process converts about 600 million tons of hydrogen into helium every second
                in our Sun, releasing energy equivalent to billions of nuclear bombs.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Famous Stars</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid md:grid-cols-2 gap-4">
              <div className="border rounded-lg p-4">
                <h4>Sirius (Dog Star)</h4>
                <p className="text-muted-foreground">
                  Brightest star in Earth's night sky, actually a binary star system 8.6 light-years away.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Betelgeuse</h4>
                <p className="text-muted-foreground">
                  Red supergiant in Orion, about 700 light-years away. Expected to go supernova someday.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Proxima Centauri</h4>
                <p className="text-muted-foreground">
                  Closest star to our Solar System at 4.24 light-years, a small red dwarf.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Polaris (North Star)</h4>
                <p className="text-muted-foreground">
                  Currently aligned with Earth's rotational axis, used for navigation for centuries.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-planets')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Planets
          </Button>
          <Button onClick={() => onNavigate('lesson-galaxies')}>
            Next: Galaxies
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
