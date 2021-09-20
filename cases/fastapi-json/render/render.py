import csv
from collections import namedtuple
from pathlib import Path

import jinja2

Result = namedtuple(
    "Result",
    [
        "app",
        "server",
        "req",
        "reqs",
        "lt50",
        "lt75",
        "lt90",
        "lt_avg",
        "es",
        "er",
        "et",
    ],
)


def render():
    with open(Path(__file__).parent.parent / "results/api.csv") as csvfile:
        results = sorted(
            [
                Result(app, server, int(req), round(int(req) / 60), *row)
                for app, server, req, *row in csv.reader(csvfile)
            ],
            key=lambda x: x.req,
            reverse=True,
        )

    template = jinja2.Template((Path(__file__).parent / "README.jinja").read_text())
    with open(Path(__file__).parent.parent / "README.md", "w") as target:
        target.write(template.render(results=results))


if __name__ == "__main__":
    render()
