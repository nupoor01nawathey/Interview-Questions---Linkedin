from factories.extractor import Extractor

class WorkFlowType:
    def __init__(self, params):
        self.params = params

    def runner(self):
        if self.params.get("activity_type") == "extractor":
            return Extractor(self.params).runner()
        # elif self.activity_type == "merge":
        #     return DeltaMerge().runner()
        else:
            raiseValue(f"Un-supported operation type: {operation_type}")
