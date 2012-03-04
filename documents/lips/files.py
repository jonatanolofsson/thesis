#!/usr/bin/env python
import yaml

base = "lips/"

with open(base+'files.yaml') as f:
    files = yaml.load(f)

with open(base+'files.tex', 'w') as f:
    for document in files['documents']:
        f.write(("\\newcommand{{\\latest{lcname}}}{{{group}\\_{name}\\_v{version}\\_{date}.pdf}}\n"
                +"\\newcommand{{\\version{lcname}}}{{{version}}}\n"
                +"\\newcommand{{\\date{lcname}}}{{{date}}}\n"
                )
            .format(lcname=document['name'].lower(), name=document['name'], group=files['group'], date=document['date'], version=document['version']))
