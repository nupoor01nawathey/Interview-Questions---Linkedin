from Config import MyConfig
import Config

def main():
    rect = MyConfig(45.0, 56.98, 'utils/abc.ini')
    print(rect.parser())  # 'sections': ['dev', 'sit', 'prod'], 'sit_library': '/usr/local/lib', 'log_errors': True, 'port': 8080, 'nworkers': 32}
    
    print(rect.print_params())
    # inside print_config
    # /usr/local/lib
    # leaving print_config

if __name__ == "__main__":
    main()
