Class {
	#name : #SpFuel4Strategy,
	#superclass : #SpStrategy,
	#category : #'SimplePersistence-Core-Core'
}

{ #category : #testing }
SpFuel4Strategy class >> isActive [
	"I am abstract"
	^ false
]

{ #category : #accessing }
SpFuel4Strategy >> materialize: anSpBackup from: aFileReference [

	| materialization |
	materialization := (self new: FLMaterializer withFile: aFileReference) materialize.
		
	anSpBackup
		header: materialization header additionalObjects;
		spData: materialization root;
		file: aFileReference
]

{ #category : #accessing }
SpFuel4Strategy >> materializeHeaderFrom: aFileReference [

	^ (self new: FLMaterializer withFile: aFileReference) materializeHeader additionalObjects
]

{ #category : #accessing }
SpFuel4Strategy >> new: anFlClass withFile: aFileReference [
	self subclassResponsibility
]

{ #category : #protocol }
SpFuel4Strategy >> serialize: anSpBackup to: aFileReference [

	| serializer |
	serializer := self new: FLSerializer withFile: aFileReference.
		
	anSpBackup header keysAndValuesDo: [ :k :v |
		serializer at: k putAdditionalObject: v ].
		
	serializer 
		object: anSpBackup spData;
		serialize
]
