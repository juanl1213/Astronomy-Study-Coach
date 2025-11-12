import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "./ui/card";
import { Button } from "./ui/button";
import { Badge } from "./ui/badge";
import { Progress } from "./ui/progress";
import { 
  Globe, 
  Star, 
  Telescope, 
  Rocket, 
  Sun, 
  Moon, 
  Orbit, 
  Zap 
} from "lucide-react";
import { ImageWithFallback } from "./figma/ImageWithFallback";

interface StudyTopicsProps {
  onNavigate: (section: string) => void;
}

export function StudyTopics({ onNavigate }: StudyTopicsProps) {
  const topics = [
    {
      id: 'solar-system',
      title: 'Solar System',
      description: 'Explore planets, moons, and other celestial bodies in our solar system',
      icon: Globe,
      difficulty: 'Beginner',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '15 min',
      image: "https://images.unsplash.com/photo-1520257328559-2062fc7de0b3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzb2xhciUyMHN5c3RlbSUyMHBsYW5ldHN8ZW58MXx8fHwxNzU4OTkwMTcxfDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
      route: 'lesson-solar-system'
    },
    {
      id: 'planets',
      title: 'Planets in Detail',
      description: 'Deep dive into the characteristics of each planet',
      icon: Globe,
      difficulty: 'Beginner',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '20 min',
      image: "https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=800",
      route: 'lesson-planets'
    },
    {
      id: 'stars',
      title: 'Stars & Stellar Evolution',
      description: 'Learn about star formation, life cycles, and stellar classifications',
      icon: Star,
      difficulty: 'Intermediate',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '20 min',
      image: "https://images.unsplash.com/photo-1649212149537-6eb739f5a23a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjb25zdGVsbGF0aW9uJTIwc3RhcnMlMjBuaWdodCUyMHNreXxlbnwxfHx8fDE3NTkwMTA4NDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
      route: 'lesson-stars'
    },
    {
      id: 'galaxies',
      title: 'Galaxies',
      description: 'Discover different types of galaxies and cosmic structures',
      icon: Orbit,
      difficulty: 'Intermediate',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '18 min',
      image: "https://images.unsplash.com/photo-1504812333783-63b845853c20?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcGFjZSUyMG5lYnVsYSUyMGdhbGF4eXxlbnwxfHx8fDE3NTkwMTA4NDB8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
      route: 'lesson-galaxies'
    },
    {
      id: 'cosmology',
      title: 'Cosmology & The Universe',
      description: 'Understand the origin and evolution of the universe',
      icon: Zap,
      difficulty: 'Advanced',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '22 min',
      image: "https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800",
      route: 'lesson-cosmology'
    },
    {
      id: 'exoplanets',
      title: 'Exoplanets',
      description: 'Discover planets beyond our Solar System',
      icon: Globe,
      difficulty: 'Intermediate',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '18 min',
      image: "https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=800",
      route: 'lesson-exoplanets'
    },
    {
      id: 'black-holes',
      title: 'Black Holes',
      description: 'Explore the most extreme objects in the universe',
      icon: Zap,
      difficulty: 'Advanced',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '20 min',
      image: "https://images.unsplash.com/photo-1510266152-c97b0c5db89e?w=800",
      route: 'lesson-black-holes'
    },
    {
      id: 'nebulae',
      title: 'Nebulae',
      description: 'Beautiful clouds of gas and dust where stars are born',
      icon: Star,
      difficulty: 'Beginner',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '16 min',
      image: "https://images.unsplash.com/photo-1502134249126-9f3755a50d78?w=800",
      route: 'lesson-nebulae'
    },
    {
      id: 'asteroids',
      title: 'Asteroids & Comets',
      description: 'Rocky and icy remnants from the Solar System\'s formation',
      icon: Globe,
      difficulty: 'Beginner',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '18 min',
      image: "https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=800",
      route: 'lesson-asteroids'
    },
    {
      id: 'space-exploration',
      title: 'Space Exploration',
      description: 'Journey through humanity\'s ventures beyond Earth',
      icon: Rocket,
      difficulty: 'Beginner',
      progress: 100,
      lessons: 1,
      completedLessons: 1,
      estimatedTime: '20 min',
      image: "https://images.unsplash.com/photo-1643658771492-6cfd5413455c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhc3Ryb25hdXQlMjBzcGFjZXxlbnwxfHx8fDE3NTkwMTA4NDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
      route: 'lesson-space-exploration'
    }
  ];

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'Beginner': return 'bg-emerald-500/15 text-emerald-400 border border-emerald-500/30';
      case 'Intermediate': return 'bg-amber-500/15 text-amber-400 border border-amber-500/30';
      case 'Advanced': return 'bg-rose-500/15 text-rose-400 border border-rose-500/30';
      default: return 'bg-gray-500/15 text-gray-400 border border-gray-500/30';
    }
  };

  return (
    <div className="space-y-6">
      <div className="text-center space-y-2">
        <h1>Study Topics</h1>
        <p className="text-muted-foreground">
          Choose a topic to begin your astronomical journey through the cosmos
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {topics.map((topic) => (
          <Card key={topic.id} className="overflow-hidden hover:shadow-lg hover:border-primary/50 transition-all">
            <div className="relative">
              <ImageWithFallback 
                src={topic.image}
                alt={topic.title}
                className="w-full h-40 object-cover"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
              <div className="absolute top-3 right-3">
                <Badge className={getDifficultyColor(topic.difficulty)}>
                  {topic.difficulty}
                </Badge>
              </div>
            </div>
            
            <CardHeader className="pb-3">
              <CardTitle className="flex items-center space-x-2">
                <topic.icon className="h-5 w-5" />
                <span>{topic.title}</span>
              </CardTitle>
              <CardDescription className="text-sm">
                {topic.description}
              </CardDescription>
            </CardHeader>
            
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span>Progress</span>
                  <span className="text-muted-foreground">{topic.progress}%</span>
                </div>
                <Progress value={topic.progress} className="h-2" />
              </div>
              
              <div className="grid grid-cols-2 gap-4 text-sm">
                <div>
                  <p className="text-muted-foreground">Lessons</p>
                  <p>{topic.completedLessons}/{topic.lessons}</p>
                </div>
                <div>
                  <p className="text-muted-foreground">Est. Time</p>
                  <p>{topic.estimatedTime}</p>
                </div>
              </div>
              
              <div className="flex space-x-2">
                <Button 
                  onClick={() => onNavigate(topic.route)} 
                  className="flex-1"
                  variant={topic.progress > 0 ? 'default' : 'outline'}
                >
                  {topic.progress > 0 ? 'Review' : 'Start Learning'}
                </Button>
                <Button 
                  onClick={() => onNavigate('quiz')} 
                  variant="outline"
                  size="sm"
                >
                  Quiz
                </Button>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <Sun className="h-5 w-5" />
            <span>Learning Path Recommendations</span>
          </CardTitle>
          <CardDescription>
            Suggested order for optimal learning experience
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            <div className="flex items-center space-x-3 text-sm">
              <div className="w-6 h-6 bg-primary text-primary-foreground rounded-full flex items-center justify-center">1</div>
              <span>Start with <strong>Solar System</strong> to build foundation knowledge</span>
            </div>
            <div className="flex items-center space-x-3 text-sm">
              <div className="w-6 h-6 bg-primary text-primary-foreground rounded-full flex items-center justify-center">2</div>
              <span>Learn about <strong>Telescopes & Observation</strong> for practical skills</span>
            </div>
            <div className="flex items-center space-x-3 text-sm">
              <div className="w-6 h-6 bg-primary text-primary-foreground rounded-full flex items-center justify-center">3</div>
              <span>Explore <strong>Stars & Stellar Evolution</strong> to understand stellar physics</span>
            </div>
            <div className="flex items-center space-x-3 text-sm">
              <div className="w-6 h-6 bg-primary text-primary-foreground rounded-full flex items-center justify-center">4</div>
              <span>Study <strong>Galaxies & Nebulae</strong> for large-scale structures</span>
            </div>
            <div className="flex items-center space-x-3 text-sm">
              <div className="w-6 h-6 bg-primary text-primary-foreground rounded-full flex items-center justify-center">5</div>
              <span>Conclude with <strong>Cosmology</strong> for the complete picture</span>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}