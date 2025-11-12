import { Card, CardContent, CardHeader, CardTitle } from "./ui/card";
import { Button } from "./ui/button";
import { ExternalLink, BookOpen, Video, Telescope, Globe, Newspaper } from "lucide-react";

interface ResourcesProps {
  onNavigate: (section: string) => void;
}

export function Resources({ onNavigate }: ResourcesProps) {
  const resources = {
    websites: [
      {
        name: 'NASA',
        description: 'Official NASA website with latest space news and missions',
        url: 'https://www.nasa.gov',
        icon: Globe
      },
      {
        name: 'ESA (European Space Agency)',
        description: 'European space exploration and research',
        url: 'https://www.esa.int',
        icon: Globe
      },
      {
        name: 'Sky & Telescope',
        description: 'Astronomy news, observing guides, and resources',
        url: 'https://www.skyandtelescope.org',
        icon: Telescope
      },
      {
        name: 'Astronomy.com',
        description: 'Popular astronomy magazine and learning resources',
        url: 'https://www.astronomy.com',
        icon: Newspaper
      },
      {
        name: 'Space.com',
        description: 'Latest space news, exploration, and discoveries',
        url: 'https://www.space.com',
        icon: Newspaper
      }
    ],
    educational: [
      {
        name: 'Khan Academy Cosmology',
        description: 'Free astronomy and cosmology video lessons',
        url: 'https://www.khanacademy.org/science/cosmology-and-astronomy',
        icon: Video
      },
      {
        name: 'Crash Course Astronomy',
        description: 'Entertaining and educational astronomy video series',
        url: 'https://www.youtube.com/playlist?list=PL8dPuuaLjXtPAJr1ysd5yGIyiSFuh0mIL',
        icon: Video
      },
      {
        name: 'NASA\'s Astronomy Picture of the Day',
        description: 'Daily astronomical images with explanations',
        url: 'https://apod.nasa.gov/apod/',
        icon: BookOpen
      },
      {
        name: 'Stellarium Web',
        description: 'Online planetarium showing realistic sky',
        url: 'https://stellarium-web.org',
        icon: Telescope
      }
    ],
    tools: [
      {
        name: 'SkySafari',
        description: 'Planetarium app for stargazing (iOS/Android)',
        icon: Telescope
      },
      {
        name: 'Star Walk 2',
        description: 'Interactive astronomy guide app',
        icon: Telescope
      },
      {
        name: 'NASA App',
        description: 'Official NASA app with missions, images, and videos',
        icon: Globe
      },
      {
        name: 'ISS Detector',
        description: 'Track the International Space Station',
        icon: Globe
      }
    ],
    books: [
      {
        name: 'Cosmos by Carl Sagan',
        description: 'Classic exploration of the universe and our place in it'
      },
      {
        name: 'Astrophysics for People in a Hurry',
        description: 'By Neil deGrasse Tyson - Quick introduction to the cosmos'
      },
      {
        name: 'The Elegant Universe by Brian Greene',
        description: 'Introduction to string theory and modern physics'
      },
      {
        name: 'A Brief History of Time by Stephen Hawking',
        description: 'Cosmology from the Big Bang to black holes'
      },
      {
        name: 'The Order of Time by Carlo Rovelli',
        description: 'Fascinating exploration of the nature of time'
      }
    ]
  };

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div>
        <h1>Learning Resources</h1>
        <p className="text-muted-foreground mt-2">
          Curated collection of astronomy resources to deepen your knowledge.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <Globe className="h-5 w-5" />
            <span>Astronomy Websites</span>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          {resources.websites.map((resource, index) => {
            const Icon = resource.icon;
            return (
              <a
                key={index}
                href={resource.url}
                target="_blank"
                rel="noopener noreferrer"
                className="block p-4 border rounded-lg hover:border-primary/50 hover:bg-muted/50 transition-colors"
              >
                <div className="flex items-start justify-between">
                  <div className="flex items-start space-x-3 flex-1">
                    <div className="p-2 bg-primary/10 rounded">
                      <Icon className="h-4 w-4 text-primary" />
                    </div>
                    <div className="flex-1">
                      <div className="flex items-center space-x-2">
                        <h4>{resource.name}</h4>
                        <ExternalLink className="h-3 w-3 text-muted-foreground" />
                      </div>
                      <p className="text-sm text-muted-foreground mt-1">
                        {resource.description}
                      </p>
                    </div>
                  </div>
                </div>
              </a>
            );
          })}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <Video className="h-5 w-5" />
            <span>Educational Platforms</span>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          {resources.educational.map((resource, index) => {
            const Icon = resource.icon;
            return (
              <a
                key={index}
                href={resource.url}
                target="_blank"
                rel="noopener noreferrer"
                className="block p-4 border rounded-lg hover:border-primary/50 hover:bg-muted/50 transition-colors"
              >
                <div className="flex items-start justify-between">
                  <div className="flex items-start space-x-3 flex-1">
                    <div className="p-2 bg-primary/10 rounded">
                      <Icon className="h-4 w-4 text-primary" />
                    </div>
                    <div className="flex-1">
                      <div className="flex items-center space-x-2">
                        <h4>{resource.name}</h4>
                        <ExternalLink className="h-3 w-3 text-muted-foreground" />
                      </div>
                      <p className="text-sm text-muted-foreground mt-1">
                        {resource.description}
                      </p>
                    </div>
                  </div>
                </div>
              </a>
            );
          })}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <Telescope className="h-5 w-5" />
            <span>Mobile Apps & Tools</span>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          {resources.tools.map((resource, index) => {
            const Icon = resource.icon;
            return (
              <div
                key={index}
                className="p-4 border rounded-lg"
              >
                <div className="flex items-start space-x-3">
                  <div className="p-2 bg-primary/10 rounded">
                    <Icon className="h-4 w-4 text-primary" />
                  </div>
                  <div>
                    <h4>{resource.name}</h4>
                    <p className="text-sm text-muted-foreground mt-1">
                      {resource.description}
                    </p>
                  </div>
                </div>
              </div>
            );
          })}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <BookOpen className="h-5 w-5" />
            <span>Recommended Books</span>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          {resources.books.map((book, index) => (
            <div
              key={index}
              className="p-4 border rounded-lg"
            >
              <h4>{book.name}</h4>
              <p className="text-sm text-muted-foreground mt-1">
                {book.description}
              </p>
            </div>
          ))}
        </CardContent>
      </Card>

      <Card>
        <CardContent className="pt-6">
          <div className="text-center space-y-3">
            <p className="text-muted-foreground">
              Ready to test your knowledge?
            </p>
            <Button onClick={() => onNavigate('quiz')}>
              Take a Quiz
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
