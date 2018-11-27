import sys
from notebook.auth import passwd

TEMP = '''
#
# Jupyter Notebook Server
# Configuration File
#
# The Python Quants GmbH
#
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.port = 9999
c.NotebookApp.password = '%s'
c.NotebookApp.open_browser = False
'''


def main(args):
    pw = passwd(args[0])
    with open('/root/.jupyter/jupyter_notebook_config.py', 'w') as f:
        f.write(TEMP % (pw))
    print('Jupyter Server is running under')
    print('http://(localhost or server IP):9999')


if __name__ == '__main__':
    main(sys.argv[1:])
