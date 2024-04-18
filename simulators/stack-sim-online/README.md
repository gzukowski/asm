---

# Quick Start Guide: Launching Python App

This guide provides a quick overview of how to properly connect client with the server.


## Configuration

1. Change the "BASE_URL" to the server ip (login.py, simulator.py)

## Running the Application

Execute the following command to run the Python application:

```bash
python main.py
```

## Preparing executable
1. Create a virtual environment (optional but recommended):

    ```bash
        python -m venv venv
    ```

2. Activate the virtual environment:

    - On Windows:

        ```bash
        venv\Scripts\activate
        ```

    - On macOS and Linux:

        ```bash
        source venv/bin/activate
        ```

3. Install pyinstaller:

        ```bash
        pip install pyinstaller
        ```

4. Install pyinstaller:

        ```bash
        pip install pyinstaller
        ```

4. Run pyinstaller:

        ```bash
        pyinstaller .\main.py --onefile
        ```
        
5. The .exe should appear in dist folder

---
