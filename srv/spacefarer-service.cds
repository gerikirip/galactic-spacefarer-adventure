using { Spacefarers as Spacefarers_, Departments as Departments_, Positions as Positions_ } from '../db/schema';

@requires: 'authenticated-user'
service SpacefarerService {
    @restrict: [
        { grant: '*', to: 'galactic-commander' },
        { grant: ['READ', 'UPDATE'], to: 'authenticated-user', where: 'userName = $user' }
    ]
    entity Spacefarers as projection on Spacefarers_ {
        *,
        @readonly department.name as departmentName,
        @readonly position.name as positionName
    };

    @restrict: [
        { grant: 'READ', to: 'authenticated-user' },
    ]
    @readonly entity Departments as projection on Departments_;

    @restrict: [
        { grant: 'READ', to: 'authenticated-user' },
    ]
    @readonly entity Positions   as projection on Positions_;
}
annotate SpacefarerService.Spacefarers with @odata.draft.enabled;