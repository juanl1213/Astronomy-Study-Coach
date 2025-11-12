import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "./ui/card";
import { Progress } from "./ui/progress";
import { Button } from "./ui/button";
import { Badge } from "./ui/badge";
import { Telescope, BookOpen, Trophy, Target, Star, Rocket } from "lucide-react";
import { ImageWithFallback } from "./figma/ImageWithFallback";

interface DashboardProps {
  onNavigate: (section: string) => void;
}

export function Dashboard({ onNavigate }: DashboardProps) {
  const studyProgress = {
    solarSystem: 75,
    stars: 40,
    galaxies: 20,
    cosmology: 10
  };

  const recentAchievements = [
    { id: 1, title: "Solar System Expert", description: "Completed all planet quizzes", icon: Trophy },
    { id: 2, title: "Star Gazer", description: "Learned 10 constellation patterns", icon: Star },
    { id: 3, title: "Quiz Master", description: "Scored 90% on 5 consecutive quizzes", icon: Target }
  ];

  const quickStats = [
    { label: "Total Study Time", value: "24h 32m", icon: BookOpen },
    { label: "Quizzes Completed", value: "18", icon: Target },
    { label: "Current Streak", value: "7 days", icon: Rocket },
    { label: "Topics Mastered", value: "3/8", icon: Trophy }
  ];

  return (
    <div className="space-y-6">
      {/* Hero Section */}
      <div className="relative rounded-lg overflow-hidden border border-border shadow-xl">
        <ImageWithFallback 
          src="https://images.unsplash.com/photo-1504812333783-63b845853c20?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcGFjZSUyMG5lYnVsYSUyMGdhbGF4eXxlbnwxfHx8fDE3NTkwMTA4NDB8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
          alt="Space background"
          className="w-full h-48 object-cover"
        />
        <div className="absolute inset-0 bg-gradient-to-r from-indigo-950/95 via-indigo-950/80 to-transparent flex items-center">
          <div className="p-6 text-white">
            <h1 className="mb-2">Welcome Back, Astronomer!</h1>
            <p className="text-gray-200 mb-4">Continue your journey through the cosmos and expand your knowledge of the universe.</p>
            <Button onClick={() => onNavigate('study')} className="bg-primary hover:bg-primary/90 shadow-lg">
              <BookOpen className="mr-2 h-4 w-4" />
              Continue Learning
            </Button>
          </div>
        </div>
      </div>

      {/* Quick Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {quickStats.map((stat, index) => (
          <Card key={index} className="hover:border-primary/50 transition-colors">
            <CardContent className="p-4">
              <div className="flex items-center space-x-3">
                <div className="p-2 rounded-lg bg-primary/10">
                  <stat.icon className="h-5 w-5 text-primary" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">{stat.label}</p>
                  <p className="font-medium">{stat.value}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Study Progress */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center space-x-2">
              <div className="p-1.5 rounded-lg bg-primary/10">
                <Telescope className="h-5 w-5 text-primary" />
              </div>
              <span>Study Progress</span>
            </CardTitle>
            <CardDescription>
              Track your learning journey across different astronomy topics
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-3">
              <div>
                <div className="flex justify-between mb-1">
                  <span className="text-sm">Solar System</span>
                  <span className="text-sm text-muted-foreground">{studyProgress.solarSystem}%</span>
                </div>
                <Progress value={studyProgress.solarSystem} className="h-2" />
              </div>
              <div>
                <div className="flex justify-between mb-1">
                  <span className="text-sm">Stars & Stellar Evolution</span>
                  <span className="text-sm text-muted-foreground">{studyProgress.stars}%</span>
                </div>
                <Progress value={studyProgress.stars} className="h-2" />
              </div>
              <div>
                <div className="flex justify-between mb-1">
                  <span className="text-sm">Galaxies & Nebulae</span>
                  <span className="text-sm text-muted-foreground">{studyProgress.galaxies}%</span>
                </div>
                <Progress value={studyProgress.galaxies} className="h-2" />
              </div>
              <div>
                <div className="flex justify-between mb-1">
                  <span className="text-sm">Cosmology</span>
                  <span className="text-sm text-muted-foreground">{studyProgress.cosmology}%</span>
                </div>
                <Progress value={studyProgress.cosmology} className="h-2" />
              </div>
            </div>
            <Button onClick={() => onNavigate('study')} variant="outline" className="w-full">
              View All Topics
            </Button>
          </CardContent>
        </Card>

        {/* Recent Achievements */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center space-x-2">
              <div className="p-1.5 rounded-lg bg-accent/10">
                <Trophy className="h-5 w-5 text-accent" />
              </div>
              <span>Recent Achievements</span>
            </CardTitle>
            <CardDescription>
              Celebrate your astronomy learning milestones
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {recentAchievements.map((achievement) => (
                <div key={achievement.id} className="flex items-start space-x-3">
                  <div className="flex-shrink-0">
                    <achievement.icon className="h-5 w-5 text-yellow-500" />
                  </div>
                  <div className="flex-1">
                    <p className="font-medium">{achievement.title}</p>
                    <p className="text-sm text-muted-foreground">{achievement.description}</p>
                  </div>
                  <Badge variant="secondary">New</Badge>
                </div>
              ))}
            </div>
            <Button onClick={() => onNavigate('progress')} variant="outline" className="w-full mt-4">
              View All Achievements
            </Button>
          </CardContent>
        </Card>
      </div>

      {/* Quick Actions */}
      <Card>
        <CardHeader>
          <CardTitle>Quick Actions</CardTitle>
          <CardDescription>Jump into your astronomy studies</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Button onClick={() => onNavigate('quiz')} variant="outline" className="h-20 flex-col">
              <Target className="h-6 w-6 mb-2" />
              Take a Quiz
            </Button>
            <Button onClick={() => onNavigate('flashcards')} variant="outline" className="h-20 flex-col">
              <BookOpen className="h-6 w-6 mb-2" />
              Study Flashcards
            </Button>
            <Button onClick={() => onNavigate('constellations')} variant="outline" className="h-20 flex-col">
              <Star className="h-6 w-6 mb-2" />
              Explore Constellations
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}