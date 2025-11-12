import { Card, CardContent, CardHeader, CardTitle } from "./ui/card";
import { Badge } from "./ui/badge";
import { Button } from "./ui/button";
import {
  Trophy,
  Star,
  Zap,
  Target,
  Award,
  Crown,
  Sparkles,
  Flame,
  Brain,
  BookOpen,
  ArrowLeft
} from "lucide-react";

interface AchievementsProps {
  onNavigate: (section: string) => void;
}

export function Achievements({ onNavigate }: AchievementsProps) {
  const achievements = [
    {
      id: 1,
      title: 'First Steps',
      description: 'Complete your first quiz',
      icon: Star,
      earned: true,
      earnedDate: '2025-09-15',
      points: 10,
      rarity: 'common'
    },
    {
      id: 2,
      title: 'Perfect Score',
      description: 'Score 100% on any quiz',
      icon: Trophy,
      earned: false,
      points: 50,
      rarity: 'rare'
    },
    {
      id: 3,
      title: 'Quiz Master',
      description: 'Complete all available quizzes',
      icon: Crown,
      earned: false,
      points: 100,
      rarity: 'legendary'
    },
    {
      id: 4,
      title: 'Speed Demon',
      description: 'Complete a quiz in under 5 minutes',
      icon: Zap,
      earned: true,
      earnedDate: '2025-09-20',
      points: 25,
      rarity: 'uncommon'
    },
    {
      id: 5,
      title: 'Consistent Learner',
      description: 'Study for 7 days in a row',
      icon: Flame,
      earned: true,
      earnedDate: '2025-09-28',
      points: 30,
      rarity: 'uncommon'
    },
    {
      id: 6,
      title: 'Flashcard Pro',
      description: 'Review 100 flashcards',
      icon: Brain,
      earned: false,
      points: 40,
      rarity: 'rare'
    },
    {
      id: 7,
      title: 'Constellation Explorer',
      description: 'View all constellations',
      icon: Sparkles,
      earned: true,
      earnedDate: '2025-09-25',
      points: 20,
      rarity: 'common'
    },
    {
      id: 8,
      title: 'Scholar',
      description: 'Complete all lessons',
      icon: BookOpen,
      earned: false,
      points: 75,
      rarity: 'epic'
    },
    {
      id: 9,
      title: 'Sharp Shooter',
      description: 'Answer 10 questions correctly in a row',
      icon: Target,
      earned: true,
      earnedDate: '2025-09-22',
      points: 35,
      rarity: 'uncommon'
    },
    {
      id: 10,
      title: 'Knowledge Seeker',
      description: 'Spend 10 hours studying',
      icon: Award,
      earned: false,
      points: 60,
      rarity: 'epic'
    },
    {
      id: 11,
      title: 'Astronomy Expert',
      description: 'Achieve 90%+ average across all quizzes',
      icon: Crown,
      earned: false,
      points: 150,
      rarity: 'legendary'
    },
    {
      id: 12,
      title: 'Early Bird',
      description: 'Complete a study session before 8 AM',
      icon: Star,
      earned: false,
      points: 15,
      rarity: 'common'
    }
  ];

  const getRarityColor = (rarity: string) => {
    switch (rarity) {
      case 'common':
        return 'bg-slate-500/15 text-slate-400 border-slate-500/30';
      case 'uncommon':
        return 'bg-emerald-500/15 text-emerald-400 border-emerald-500/30';
      case 'rare':
        return 'bg-blue-500/15 text-blue-400 border-blue-500/30';
      case 'epic':
        return 'bg-purple-500/15 text-purple-400 border-purple-500/30';
      case 'legendary':
        return 'bg-amber-500/15 text-amber-400 border-amber-500/30';
      default:
        return '';
    }
  };

  const totalPoints = achievements
    .filter(a => a.earned)
    .reduce((sum, a) => sum + a.points, 0);

  const earnedCount = achievements.filter(a => a.earned).length;
  const totalCount = achievements.length;

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1>Achievements</h1>
          <p className="text-muted-foreground mt-2">
            Earn badges and track your learning milestones.
          </p>
        </div>
        <Button variant="ghost" onClick={() => onNavigate('progress')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Progress
        </Button>
      </div>

      <div className="grid md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-primary/10 rounded-lg">
                <Trophy className="h-6 w-6 text-primary" />
              </div>
              <div>
                <div className="text-muted-foreground">Unlocked</div>
                <div>
                  {earnedCount} / {totalCount}
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-accent/10 rounded-lg">
                <Star className="h-6 w-6 text-accent" />
              </div>
              <div>
                <div className="text-muted-foreground">Total Points</div>
                <div>{totalPoints}</div>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-primary/10 rounded-lg">
                <Zap className="h-6 w-6 text-primary" />
              </div>
              <div>
                <div className="text-muted-foreground">Completion</div>
                <div>{Math.round((earnedCount / totalCount) * 100)}%</div>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-accent/10 rounded-lg">
                <Crown className="h-6 w-6 text-accent" />
              </div>
              <div>
                <div className="text-muted-foreground">Rank</div>
                <div>Explorer</div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="space-y-4">
        <h2>Your Achievements</h2>
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
          {achievements.map((achievement) => {
            const Icon = achievement.icon;
            return (
              <Card
                key={achievement.id}
                className={`${achievement.earned ? 'border-primary/50' : 'opacity-60'}`}
              >
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex items-start space-x-3">
                      <div
                        className={`p-3 rounded-lg ${
                          achievement.earned ? 'bg-primary/10' : 'bg-muted'
                        }`}
                      >
                        <Icon
                          className={`h-6 w-6 ${
                            achievement.earned ? 'text-primary' : 'text-muted-foreground'
                          }`}
                        />
                      </div>
                      <div className="flex-1">
                        <CardTitle className="text-base">{achievement.title}</CardTitle>
                        <Badge
                          className={`mt-1 ${getRarityColor(achievement.rarity)}`}
                          variant="outline"
                        >
                          {achievement.rarity}
                        </Badge>
                      </div>
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-muted-foreground mb-3">
                    {achievement.description}
                  </p>
                  <div className="flex items-center justify-between text-sm">
                    <span className="text-muted-foreground">
                      {achievement.points} points
                    </span>
                    {achievement.earned && achievement.earnedDate && (
                      <span className="text-primary">
                        {new Date(achievement.earnedDate).toLocaleDateString()}
                      </span>
                    )}
                    {!achievement.earned && (
                      <span className="text-muted-foreground">Locked</span>
                    )}
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Progress to Next Rank</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="space-y-2">
            <div className="flex items-center justify-between">
              <span>Explorer → Astronomer</span>
              <span className="text-muted-foreground">{totalPoints} / 500 points</span>
            </div>
            <div className="h-3 bg-muted rounded-full overflow-hidden">
              <div
                className="h-full bg-primary transition-all"
                style={{ width: `${(totalPoints / 500) * 100}%` }}
              />
            </div>
          </div>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
            <div className="text-center p-3 bg-muted/50 rounded-lg">
              <div className="text-muted-foreground">Novice</div>
              <div>0-100 pts</div>
            </div>
            <div className="text-center p-3 bg-primary/10 rounded-lg border-2 border-primary">
              <div className="text-muted-foreground">Explorer</div>
              <div>101-500 pts</div>
            </div>
            <div className="text-center p-3 bg-muted/50 rounded-lg">
              <div className="text-muted-foreground">Astronomer</div>
              <div>501-1000 pts</div>
            </div>
            <div className="text-center p-3 bg-muted/50 rounded-lg">
              <div className="text-muted-foreground">Astrophysicist</div>
              <div>1000+ pts</div>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
