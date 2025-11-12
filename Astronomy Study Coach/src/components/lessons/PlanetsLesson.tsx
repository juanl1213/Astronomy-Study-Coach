import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { ImageWithFallback } from "../figma/ImageWithFallback";

interface PlanetsLessonProps {
  onNavigate: (section: string) => void;
}

export function PlanetsLesson({ onNavigate }: PlanetsLessonProps) {
  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <Button variant="ghost" onClick={() => onNavigate('study')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Topics
        </Button>
        <Button onClick={() => onNavigate('quiz-planets')}>
          Take Quiz
          <ArrowRight className="ml-2 h-4 w-4" />
        </Button>
      </div>

      <div className="space-y-6">
        <div>
          <h1>Planets in Detail</h1>
          <p className="text-muted-foreground mt-2">
            Deep dive into the characteristics and features of each planet in our Solar System.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Mercury - The Swift Planet</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1742473926437-fae4b1f21291?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwbGFuZXQlMjBtZXJjdXJ5JTIwc3VyZmFjZXxlbnwxfHx8fDE3NjA2MzAwMTd8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
              alt="Mercury - smallest planet in the solar system with a cratered gray surface"
              className="w-full h-48 object-cover rounded-lg"
            />
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Characteristics</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Smallest planet in the Solar System</li>
                  <li>No atmosphere to retain heat</li>
                  <li>Heavily cratered surface</li>
                  <li>Named after Roman messenger god</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Orbital period: 88 Earth days</li>
                  <li>Day length: 59 Earth days</li>
                  <li>Temperature: -173°C to 427°C</li>
                  <li>Distance from Sun: 0.39 AU</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Venus - Earth's Twin</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1639393455114-84df73f758cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwbGFuZXQlMjB2ZW51cyUyMGF0bW9zcGhlcmV8ZW58MXx8fHwxNzYwNjMwMDE4fDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
              alt="Venus - bright yellowish planet with thick atmosphere"
              className="w-full h-48 object-cover rounded-lg"
            />
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Characteristics</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Similar size to Earth</li>
                  <li>Hottest planet in Solar System</li>
                  <li>Thick, toxic atmosphere</li>
                  <li>Rotates backwards (retrograde)</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Orbital period: 225 Earth days</li>
                  <li>Day length: 243 Earth days</li>
                  <li>Surface temperature: 464°C</li>
                  <li>Distance from Sun: 0.72 AU</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Earth - Our Home Planet</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1612026934848-464065aa2c8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwbGFuZXQlMjBlYXJ0aCUyMHNwYWNlfGVufDF8fHx8MTc2MDU0Mzc0Nnww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
              alt="Earth - blue planet with white clouds from space"
              className="w-full h-48 object-cover rounded-lg"
            />
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Characteristics</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Only known planet with life</li>
                  <li>71% covered by water</li>
                  <li>Protective magnetic field</li>
                  <li>One natural satellite (Moon)</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Orbital period: 365.25 days</li>
                  <li>Day length: 24 hours</li>
                  <li>Average temperature: 15°C</li>
                  <li>Distance from Sun: 1.0 AU</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Mars - The Red Planet</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwbGFuZXQlMjBtYXJzJTIwcmVkfGVufDF8fHx8MTc2MDYzMDAxOXww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
              alt="Mars - the red planet with visible surface features"
              className="w-full h-48 object-cover rounded-lg"
            />
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Characteristics</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Red color from iron oxide</li>
                  <li>Home to Olympus Mons (largest volcano)</li>
                  <li>Thin atmosphere (mostly CO₂)</li>
                  <li>Evidence of ancient water</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Orbital period: 687 Earth days</li>
                  <li>Day length: 24.6 hours</li>
                  <li>Average temperature: -63°C</li>
                  <li>Distance from Sun: 1.52 AU</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Jupiter - The Gas Giant</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1614314169000-4cf229a1db33?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwbGFuZXQlMjBqdXBpdGVyJTIwZ3JlYXQlMjByZWQlMjBzcG90fGVufDF8fHx8MTc2MDYzMDAxOXww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
              alt="Jupiter - gas giant with visible bands and Great Red Spot"
              className="w-full h-48 object-cover rounded-lg"
            />
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Characteristics</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Largest planet in Solar System</li>
                  <li>Great Red Spot (giant storm)</li>
                  <li>At least 79 known moons</li>
                  <li>Strong magnetic field</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Orbital period: 12 Earth years</li>
                  <li>Day length: 10 hours</li>
                  <li>Cloud-top temperature: -145°C</li>
                  <li>Distance from Sun: 5.2 AU</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Saturn - The Ringed Planet</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1614732414444-096e5f1122d5?w=800"
              alt="Saturn"
              className="w-full h-48 object-cover rounded-lg"
            />
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Characteristics</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Spectacular ring system</li>
                  <li>Second-largest planet</li>
                  <li>At least 82 known moons</li>
                  <li>Least dense planet</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Orbital period: 29 Earth years</li>
                  <li>Day length: 10.7 hours</li>
                  <li>Cloud-top temperature: -178°C</li>
                  <li>Distance from Sun: 9.5 AU</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Uranus - The Tilted Planet</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1639548206689-1a5238f8d5bb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwbGFuZXQlMjB1cmFudXMlMjBibHVlfGVufDF8fHx8MTc2MDYzMDAxOXww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
              alt="Uranus - pale blue ice giant planet"
              className="w-full h-48 object-cover rounded-lg"
            />
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Characteristics</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Rotates on its side (98° tilt)</li>
                  <li>Ice giant composition</li>
                  <li>Faint ring system</li>
                  <li>27 known moons</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Orbital period: 84 Earth years</li>
                  <li>Day length: 17.2 hours</li>
                  <li>Cloud-top temperature: -224°C</li>
                  <li>Distance from Sun: 19.2 AU</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Neptune - The Windy Planet</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <ImageWithFallback
              src="https://images.unsplash.com/photo-1639921884918-8d28ab2e39a4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwbGFuZXQlMjBuZXB0dW5lJTIwZGVlcCUyMGJsdWV8ZW58MXx8fHwxNzYwNjMwMDIwfDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
              alt="Neptune - deep blue ice giant planet"
              className="w-full h-48 object-cover rounded-lg"
            />
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4>Characteristics</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Fastest winds in Solar System</li>
                  <li>Deep blue color from methane</li>
                  <li>14 known moons</li>
                  <li>Dark spots (storms)</li>
                </ul>
              </div>
              <div>
                <h4>Key Facts</h4>
                <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                  <li>Orbital period: 165 Earth years</li>
                  <li>Day length: 16 hours</li>
                  <li>Cloud-top temperature: -214°C</li>
                  <li>Distance from Sun: 30.1 AU</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-between pt-4">
          <Button variant="outline" onClick={() => onNavigate('lesson-solar-system')}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous: Solar System
          </Button>
          <Button onClick={() => onNavigate('lesson-stars')}>
            Next: Stars & Stellar Evolution
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}
