import obd

class OBDManager:
    def __init__(self):
        self.connection = None

    def connect(self):
        try:
            self.connection = obd.OBD()  # auto-connect
            return self.connection.is_connected()
        except:
            return False

    def read_voltage(self):
        if self.connection and self.connection.is_connected():
            response = self.connection.query(obd.commands.ELM_VOLTAGE)
            return response.value
        return None
