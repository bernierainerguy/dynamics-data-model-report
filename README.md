# Dynamics Data Model Report

A transportable managed Dataverse solution that reports the live data model of the environment into which it is imported.

## Features

- Lists standard and custom Dataverse tables.
- Shows columns, types, required levels, descriptions, and lookup targets.
- Shows one-to-many, many-to-one, and many-to-many relationships.
- Filters tables by name and custom/standard scope.
- Filters the report to selected solutions or all non-default solutions.
- Builds a self-contained, paginated HTML report for all visible tables.
- Produces a complete single-table report containing both columns and relationships.
- Downloads HTML and opens the system Print dialog to save a PDF.
- Uses the current signed-in Dataverse session; no connection string or environment URL is stored.

## Build

Prerequisites: .NET SDK and Microsoft Power Platform CLI.

```bash
dotnet build --configuration Release
```

The managed ZIP is written beneath `bin/Release/` and is intentionally not committed to this repository.

## Import and open

1. In Power Apps, select the target environment.
2. Go to **Solutions** > **Import solution** and import the managed ZIP.
3. After import, open this URL, replacing the host with the target environment URL:

   `https://YOUR-ORG.crm.dynamics.com/WebResources/brg_datamodelreport.html`

The user must be signed in and have permission to read Dataverse customization metadata. The report is read-only.

## Source structure

- `src/WebResources/brg_datamodelreport.html` — self-contained report UI and metadata client.
- `src/WebResources/brg_datamodelreport.html.data.xml` — Dataverse web resource metadata.
- `src/Other/Solution.xml` — solution manifest.
- `DynamicsDataModelReport.cdsproj` — managed solution build project.
