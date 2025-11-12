import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface CosmologyLessonProps {
  onNavigate: (section: string) => void;
}

export function CosmologyLesson({ onNavigate }: CosmologyLessonProps) {
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
          <h1>Cosmology & The Universe</h1>
          <p className="text-muted-foreground mt-2">
            Study the origin, evolution, and ultimate fate of the universe itself.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>The Big Bang Theory</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800"
              alt="Deep space"
              className="w-full h-64 object-cover rounded-lg"
            />
            <p>
              The Big Bang theory is the prevailing cosmological model explaining the universe's
              origin. About 13.8 billion years ago, the universe began from an extremely hot, dense
              state and has been expanding ever since.
            </p>
            <div className="space-y-2">
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Time = 0:</strong> Universe begins in an infinitely hot, dense state
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>First seconds:</strong> Rapid expansion (inflation), fundamental particles form
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>First 3 minutes:</strong> Protons and neutrons form, then light nuclei
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>380,000 years:</strong> Atoms form, universe becomes transparent
                </div>
              </div>
              <div className="flex items-start">
                <span className="text-primary mr-2">•</span>
                <div>
                  <strong>Millions of years later:</strong> First stars and galaxies form
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Evidence for the Big Bang</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>Cosmic Microwave Background (CMB)</h4>
              <p className="text-muted-foreground">
                Faint radiation from all directions in space, the "afterglow" of the Big Bang.
                Discovered in 1964, it provides a snapshot of the universe when it was only
                380,000 years old.
              </p>
            </div>
            <div>
              <h4>Hubble's Law & Expansion</h4>
              <p className="text-muted-foreground">
                Galaxies are moving away from us, and the farther away they are, the faster
                they're receding. This indicates the universe is expanding.
              </p>
            </div>
            <div>
              <h4>Abundance of Light Elements</h4>
              <p className="text-muted-foreground">
                The observed ratios of hydrogen, helium, and lithium match predictions from
                Big Bang nucleosynthesis.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Expanding Universe</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Space itself is expanding, carrying galaxies with it. This doesn't mean galaxies
              are moving through space - rather, space between galaxies is growing.
            </p>
            <div className="bg-muted/50 p-4 rounded-lg">
              <strong>Redshift</strong>
              <p className="text-muted-foreground mt-2">
                As galaxies move away from us, their light is stretched to longer (redder)
                wavelengths. The amount of redshift tells us how fast a galaxy is receding.
              </p>
            </div>
            <div className="bg-muted/50 p-4 rounded-lg mt-3">
              <strong>Accelerating Expansion</strong>
              <p className="text-muted-foreground mt-2">
                Discovered in 1998, the universe's expansion is accelerating, driven by
                mysterious "dark energy." This discovery won the Nobel Prize in Physics in 2011.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Dark Matter & Dark Energy</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>Dark Matter (~27% of universe)</h4>
              <p className="text-muted-foreground">
                Invisible matter that doesn't emit light but has gravitational effects. It's
                detected through its gravitational influence on visible matter, radiation, and
                the structure of the universe.
              </p>
              <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                <li>Holds galaxies and galaxy clusters together</li>
                <li>Five times more abundant than regular matter</li>
                <li>Nature still unknown - one of astronomy's biggest mysteries</li>
              </ul>
            </div>
            <div className="mt-4">
              <h4>Dark Energy (~68% of universe)</h4>
              <p className="text-muted-foreground">
                Mysterious form of energy causing the universe's expansion to accelerate.
                Its nature is one of the biggest questions in cosmology.
              </p>
              <ul className="list-disc list-inside mt-2 space-y-1 text-muted-foreground">
                <li>Causes accelerated expansion</li>
                <li>Uniform throughout space</li>
                <li>May be a property of space itself</li>
              </ul>
            </div>
            <div className="bg-muted/50 p-4 rounded-lg mt-4">
              <strong>Regular Matter (~5% of universe)</strong>
              <p className="text-muted-foreground mt-2">
                Everything we can see - stars, planets, galaxies, gas, dust - makes up only
                about 5% of the universe!
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Shape and Size of the Universe</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4>Observable Universe</h4>
              <p className="text-muted-foreground">
                The part of the universe we can see, limited by the speed of light and the age
                of the universe. Radius: about 46.5 billion light-years.
              </p>
            </div>
            <div>
              <h4>Beyond the Observable</h4>
              <p className="text-muted-foreground">
                The universe extends far beyond what we can observe. The total size may be
                infinite.
              </p>
            </div>
            <div>
              <h4>Geometry</h4>
              <p className="text-muted-foreground">
                Measurements suggest the universe is "flat" - parallel lines stay parallel
                forever. This has implications for its ultimate fate.
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>The Fate of the Universe</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p>
              Based on current understanding, the universe will continue expanding forever,
              leading to different possible scenarios:
            </p>
            <div className="space-y-3">
              <div className="border rounded-lg p-4">
                <h4>Heat Death (Most Likely)</h4>
                <p className="text-muted-foreground">
                  As expansion continues, galaxies move apart, stars burn out, and the universe
                  becomes cold and dark over trillions of years.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Big Rip (If dark energy increases)</h4>
                <p className="text-muted-foreground">
                  If dark energy grows stronger, it could eventually tear apart galaxies, stars,
                  planets, and even atoms.
                </p>
              </div>
              <div className="border rounded-lg p-4">
                <h4>Big Crunch (Unlikely)</h4>
                <p className="text-muted-foreground">
                  If there's enough matter, gravity could reverse the expansion, causing the
                  universe to collapse back. Current evidence suggests this won't happen.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Key Cosmological Questions</CardTitle>
          </CardHeader>
          <CardContent>
            <ul className="space-y-2">
              <li className="flex items-start">
                <span className="text-primary mr-2">?</span>
                <span>What is the nature of dark matter and dark energy?</span>
              </li>
              <li className="flex items-start">
                <span className="text-primary mr-2">?</span>
                <span>What caused the Big Bang?</span>
              </li>
              <li className="flex items-start">
                <span className="text-primary mr-2">?</span>
                <span>Is our universe part of a multiverse?</span>
              </li>
              <li className="flex items-start">
                <span className="text-primary mr-2">?</span>
                <span>What happened during the first moments of the Big Bang?</span>
              </li>
              <li className="flex items-start">
                <span className="text-primary mr-2">?</span>
                <span>Will the universe's expansion continue forever?</span>
              </li>
            </ul>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-galaxies')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Galaxies
          </Button>
          <Button onClick={() => onNavigate('lesson-exoplanets')}>
            Next: Exoplanets
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
