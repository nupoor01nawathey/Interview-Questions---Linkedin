import configparser

class MyConfig:
    def __init__(self,  length, width, config_path):
        self.side_1 = length
        self.side_2 = width
        self.config_path = config_path
         
    def area(self):
        self.side_1*self.side_2 
          
    def parser(self):
        config = configparser.ConfigParser()
        config.read(self.config_path)
        self.ch0 = { 
            'sections' : config.sections(),
            'sit_library': config.get('sit','library'),
            'log_errors' : config.getboolean('prod','log_errors'),
            'port' : config.getint('dev','port'),
            'nworkers' : config.getint('dev','nworkers')
            }
        print(self.ch0)

    def print_params(self):
        print("inside print_config")
        print(self.ch0['sit_library'])
        print("leaving print_config")
