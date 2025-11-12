import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "./ui/card";
import { Button } from "./ui/button";
import { Badge } from "./ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "./ui/tabs";
import { 
  Star, 
  Eye, 
  Calendar, 
  MapPin, 
  Info,
  Navigation,
  Clock
} from "lucide-react";
import { ImageWithFallback } from "./figma/ImageWithFallback";

interface Constellation {
  id: string;
  name: string;
  latinName: string;
  season: string;
  hemisphere: 'Northern' | 'Southern' | 'Both';
  brightness: number;
  size: 'Large' | 'Medium' | 'Small';
  stars: number;
  mythology: string;
  mainStars: string[];
  bestViewing: string;
  coordinates: {
    ra: string;
    dec: string;
  };
}

interface ConstellationGuideProps {
  onNavigate: (section: string) => void;
}

export function ConstellationGuide({ onNavigate }: ConstellationGuideProps) {
  const [selectedConstellation, setSelectedConstellation] = useState<string | null>(null);
  const [viewMode, setViewMode] = useState<'grid' | 'detail'>('grid');

  const constellations: Constellation[] = [
    {
      id: 'ursa-major',
      name: 'Big Dipper',
      latinName: 'Ursa Major',
      season: 'Spring',
      hemisphere: 'Northern',
      brightness: 2.0,
      size: 'Large',
      stars: 7,
      mythology: 'Known as the Great Bear in Greek mythology. Zeus placed Callisto in the sky as a bear after she was transformed by his jealous wife Hera.',
      mainStars: ['Dubhe', 'Merak', 'Phecda', 'Megrez', 'Alioth', 'Mizar', 'Alkaid'],
      bestViewing: 'April to June, best seen in evening sky during spring months',
      coordinates: { ra: '11h 00m', dec: '+50°' }
    },
    {
      id: 'orion',
      name: 'The Hunter',
      latinName: 'Orion',
      season: 'Winter',
      hemisphere: 'Both',
      brightness: 1.5,
      size: 'Large',
      stars: 8,
      mythology: 'A great hunter in Greek mythology. Orion boasted he could kill any animal on Earth, which led to his placement in the sky.',
      mainStars: ['Betelgeuse', 'Rigel', 'Bellatrix', 'Mintaka', 'Alnilam', 'Alnitak', 'Saiph', 'Meissa'],
      bestViewing: 'December to February, visible worldwide during winter months',
      coordinates: { ra: '05h 30m', dec: '+00°' }
    },
    {
      id: 'cassiopeia',
      name: 'The Queen',
      latinName: 'Cassiopeia',
      season: 'Autumn',
      hemisphere: 'Northern',
      brightness: 2.5,
      size: 'Medium',
      stars: 5,
      mythology: 'Named after a vain queen in Greek mythology who boasted about her beauty. She was placed in the sky as punishment.',
      mainStars: ['Schedar', 'Caph', 'Gamma Cas', 'Ruchbah', 'Segin'],
      bestViewing: 'October to December, circumpolar from northern latitudes',
      coordinates: { ra: '01h 00m', dec: '+60°' }
    },
    {
      id: 'leo',
      name: 'The Lion',
      latinName: 'Leo',
      season: 'Spring',
      hemisphere: 'Both',
      brightness: 1.8,
      size: 'Large',
      stars: 6,
      mythology: 'Represents the Nemean Lion, a monster defeated by Hercules as his first labor. Zeus placed it in the sky to honor the lion.',
      mainStars: ['Regulus', 'Algieba', 'Denebola', 'Zosma', 'Ras Elased', 'Adhafera'],
      bestViewing: 'March to May, best seen during spring evenings',
      coordinates: { ra: '10h 30m', dec: '+15°' }
    },
    {
      id: 'cygnus',
      name: 'The Swan',
      latinName: 'Cygnus',
      season: 'Summer',
      hemisphere: 'Northern',
      brightness: 1.9,
      size: 'Large',
      stars: 6,
      mythology: 'The swan form taken by Zeus in Greek mythology. Also known as the Northern Cross due to its distinctive cross shape.',
      mainStars: ['Deneb', 'Sadr', 'Gienah', 'Delta Cyg', 'Albireo', 'Fawaris'],
      bestViewing: 'July to September, high overhead during summer nights',
      coordinates: { ra: '20h 30m', dec: '+40°' }
    },
    {
      id: 'southern-cross',
      name: 'Southern Cross',
      latinName: 'Crux',
      season: 'Year-round',
      hemisphere: 'Southern',
      brightness: 1.2,
      size: 'Small',
      stars: 4,
      mythology: 'The smallest constellation, known for its distinctive cross shape. Important for navigation in the Southern Hemisphere.',
      mainStars: ['Acrux', 'Gacrux', 'Imai', 'Mimosa'],
      bestViewing: 'Visible year-round from southern latitudes, best in autumn',
      coordinates: { ra: '12h 30m', dec: '-60°' }
    }
  ];

  const selectedConst = selectedConstellation 
    ? constellations.find(c => c.id === selectedConstellation)
    : null;

  const getSizeColor = (size: string) => {
    switch (size) {
      case 'Large': return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300';
      case 'Medium': return 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300';
      case 'Small': return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300';
      default: return 'bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-300';
    }
  };

  const getSeasonColor = (season: string) => {
    switch (season) {
      case 'Spring': return 'bg-green-500';
      case 'Summer': return 'bg-yellow-500';
      case 'Autumn': return 'bg-orange-500';
      case 'Winter': return 'bg-blue-500';
      case 'Year-round': return 'bg-purple-500';
      default: return 'bg-gray-500';
    }
  };

  if (viewMode === 'detail' && selectedConst) {
    return (
      <div className="max-w-4xl mx-auto space-y-6">
        <Card>
          <CardContent className="p-4">
            <Button 
              variant="outline" 
              onClick={() => setViewMode('grid')}
              className="mb-4"
            >
              ← Back to Constellation Guide
            </Button>
            
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <div className="space-y-4">
                <div>
                  <h1 className="mb-2">{selectedConst.name}</h1>
                  <p className="text-muted-foreground italic">{selectedConst.latinName}</p>
                </div>

                <div className="flex flex-wrap gap-2">
                  <Badge className={getSizeColor(selectedConst.size)}>{selectedConst.size}</Badge>
                  <Badge variant="outline">{selectedConst.hemisphere} Hemisphere</Badge>
                  <Badge 
                    variant="outline" 
                    className="flex items-center space-x-1"
                  >
                    <div 
                      className={`w-2 h-2 rounded-full ${getSeasonColor(selectedConst.season)}`}
                    />
                    <span>{selectedConst.season}</span>
                  </Badge>
                </div>

                <div className="space-y-3">
                  <div className="flex items-center space-x-2">
                    <Star className="h-4 w-4 text-yellow-500" />
                    <span className="text-sm">
                      {selectedConst.stars} main stars, brightness {selectedConst.brightness}
                    </span>
                  </div>
                  <div className="flex items-center space-x-2">
                    <MapPin className="h-4 w-4 text-primary" />
                    <span className="text-sm">
                      RA: {selectedConst.coordinates.ra}, Dec: {selectedConst.coordinates.dec}
                    </span>
                  </div>
                  <div className="flex items-center space-x-2">
                    <Eye className="h-4 w-4 text-primary" />
                    <span className="text-sm">{selectedConst.bestViewing}</span>
                  </div>
                </div>
              </div>

              <div className="space-y-4">
                <div className="relative rounded-lg overflow-hidden">
                  <ImageWithFallback 
                    src="https://images.unsplash.com/photo-1649212149537-6eb739f5a23a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjb25zdGVsbGF0aW9uJTIwc3RhcnMlMjBuaWdodCUyMHNreXxlbnwxfHx8fDE3NTkwMTA4NDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
                    alt={`${selectedConst.name} constellation`}
                    className="w-full h-48 object-cover"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end">
                    <p className="p-4 text-white text-sm">
                      Constellation pattern visualization
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Tabs defaultValue="mythology" className="w-full">
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="mythology">Mythology</TabsTrigger>
            <TabsTrigger value="stars">Main Stars</TabsTrigger>
            <TabsTrigger value="observation">Observation Tips</TabsTrigger>
          </TabsList>
          
          <TabsContent value="mythology" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center space-x-2">
                  <Info className="h-5 w-5" />
                  <span>Mythology & History</span>
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p className="leading-relaxed">{selectedConst.mythology}</p>
              </CardContent>
            </Card>
          </TabsContent>
          
          <TabsContent value="stars" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center space-x-2">
                  <Star className="h-5 w-5" />
                  <span>Main Stars</span>
                </CardTitle>
                <CardDescription>
                  The brightest stars that form the constellation pattern
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  {selectedConst.mainStars.map((star, index) => (
                    <div key={index} className="flex items-center space-x-3 p-3 bg-muted rounded-lg">
                      <div className="w-8 h-8 bg-primary/10 rounded-full flex items-center justify-center">
                        <Star className="h-4 w-4 text-primary" />
                      </div>
                      <span className="font-medium">{star}</span>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>
          
          <TabsContent value="observation" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center space-x-2">
                  <Eye className="h-5 w-5" />
                  <span>Observation Guide</span>
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-3">
                    <h4 className="font-medium flex items-center space-x-2">
                      <Calendar className="h-4 w-4" />
                      <span>Best Viewing Time</span>
                    </h4>
                    <p className="text-sm text-muted-foreground">
                      {selectedConst.bestViewing}
                    </p>
                  </div>
                  <div className="space-y-3">
                    <h4 className="font-medium flex items-center space-x-2">
                      <Navigation className="h-4 w-4" />
                      <span>Finding Tips</span>
                    </h4>
                    <p className="text-sm text-muted-foreground">
                      Look for the distinctive pattern of {selectedConst.stars} bright stars. 
                      Best viewed from {selectedConst.hemisphere.toLowerCase()} hemisphere locations.
                    </p>
                  </div>
                </div>
                
                <div className="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
                  <h4 className="font-medium mb-2 flex items-center space-x-2">
                    <Clock className="h-4 w-4" />
                    <span>Observation Tips</span>
                  </h4>
                  <ul className="text-sm space-y-1 text-muted-foreground">
                    <li>• Find a location away from city lights</li>
                    <li>• Allow 15-30 minutes for your eyes to adjust to darkness</li>
                    <li>• Use a red flashlight to preserve night vision</li>
                    <li>• Look during new moon for best visibility</li>
                  </ul>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="text-center space-y-2">
        <h1>Constellation Guide</h1>
        <p className="text-muted-foreground">
          Explore the night sky and learn about the patterns of stars that have guided humanity for millennia
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <Star className="h-5 w-5" />
            <span>Night Sky Map</span>
          </CardTitle>
          <CardDescription>
            Interactive guide to finding constellations throughout the year
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="relative rounded-lg overflow-hidden mb-4">
            <ImageWithFallback 
              src="https://images.unsplash.com/photo-1649212149537-6eb739f5a23a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjb25zdGVsbGF0aW9uJTIwc3RhcnMlMjBuaWdodCUyMHNreXxlbnwxfHx8fDE3NTkwMTA4NDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
              alt="Night sky with stars"
              className="w-full h-48 object-cover"
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end">
              <p className="p-4 text-white">
                Current night sky view - constellations visible tonight
              </p>
            </div>
          </div>
          
          <div className="grid grid-cols-2 md:grid-cols-4 gap-2 text-xs">
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 bg-green-500 rounded-full" />
              <span>Spring</span>
            </div>
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 bg-yellow-500 rounded-full" />
              <span>Summer</span>
            </div>
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 bg-orange-500 rounded-full" />
              <span>Autumn</span>
            </div>
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 bg-blue-500 rounded-full" />
              <span>Winter</span>
            </div>
          </div>
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {constellations.map((constellation) => (
          <Card 
            key={constellation.id} 
            className="cursor-pointer hover:shadow-lg transition-shadow"
            onClick={() => {
              setSelectedConstellation(constellation.id);
              setViewMode('detail');
            }}
          >
            <CardHeader className="pb-3">
              <div className="flex justify-between items-start">
                <div>
                  <CardTitle className="text-lg">{constellation.name}</CardTitle>
                  <CardDescription className="italic">{constellation.latinName}</CardDescription>
                </div>
                <div className="flex flex-col items-end space-y-1">
                  <Badge className={getSizeColor(constellation.size)} variant="secondary">
                    {constellation.size}
                  </Badge>
                </div>
              </div>
            </CardHeader>
            <CardContent className="space-y-3">
              <div className="flex items-center justify-between text-sm">
                <div className="flex items-center space-x-1">
                  <div 
                    className={`w-2 h-2 rounded-full ${getSeasonColor(constellation.season)}`}
                  />
                  <span>{constellation.season}</span>
                </div>
                <div className="flex items-center space-x-1">
                  <Star className="h-3 w-3 text-yellow-500" />
                  <span>{constellation.stars}</span>
                </div>
              </div>
              
              <p className="text-sm text-muted-foreground line-clamp-2">
                {constellation.mythology.slice(0, 100)}...
              </p>
              
              <div className="flex justify-between items-center pt-2">
                <Badge variant="outline" className="text-xs">
                  {constellation.hemisphere}
                </Badge>
                <Button variant="ghost" size="sm">
                  Learn More →
                </Button>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Constellation Viewing Tips</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 text-sm">
            <div>
              <h4 className="font-medium mb-3">Best Viewing Conditions</h4>
              <ul className="space-y-2 text-muted-foreground">
                <li>• Clear, moonless nights provide the best visibility</li>
                <li>• Allow 15-30 minutes for your eyes to adjust to darkness</li>
                <li>• Find a location away from city lights and light pollution</li>
                <li>• Use a red flashlight to preserve your night vision</li>
              </ul>
            </div>
            <div>
              <h4 className="font-medium mb-3">Finding Constellations</h4>
              <ul className="space-y-2 text-muted-foreground">
                <li>• Start with the most recognizable patterns</li>
                <li>• Use bright guide stars to locate fainter constellations</li>
                <li>• Learn seasonal patterns - different constellations appear throughout the year</li>
                <li>• Consider using a star chart or astronomy app</li>
              </ul>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}