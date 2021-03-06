angular.module('doubtfire.units.modals.unit-create-modal', [])

#
# This modal allows administrators to quickly create new units
#
.factory('UnitCreateModal', ($modal) ->
  UnitCreateModal = {}

  UnitCreateModal.show = (units) ->
    $modal.open
      controller: 'UnitCreateModalCtrl'
      templateUrl: 'units/modals/unit-create-modal/unit-create-modal.tpl.html'
      resolve:
        units: -> units

  UnitCreateModal
)
.controller('UnitCreateModalCtrl', ($scope, $modalInstance, alertService, units, Unit, analyticsService) ->
  analyticsService.event 'Unit Admin', 'Started to Create Unit'
  $scope.units = units
  $scope.unit = { code: null, name: null }
  $scope.saveUnit = ->
    Unit.create(
      { unit: $scope.unit }
      (response) ->
        alertService.add("success", "Unit created.", 2000)
        $modalInstance.close()
        $scope.units.push(response)
        analyticsService.event 'Unit Admin', 'Saved New Unit'
      (response) ->
        alertService.add 'danger', "Error creating unit - #{response.data.error}"
    )
)
