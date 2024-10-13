"""empty message

Revision ID: d8e9a83e7bbc
Revises: fd827130766f
Create Date: 2024-09-01 08:15:17.414939

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = 'd8e9a83e7bbc'
down_revision = 'fd827130766f'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('areas', schema=None) as batch_op:
        batch_op.drop_column('lng')
        batch_op.drop_column('lat')

    with op.batch_alter_table('crags', schema=None) as batch_op:
        batch_op.drop_column('lng')
        batch_op.drop_column('lat')

    with op.batch_alter_table('sectors', schema=None) as batch_op:
        batch_op.drop_column('lng')
        batch_op.drop_column('lat')

    with op.batch_alter_table('topo_images', schema=None) as batch_op:
        batch_op.drop_column('lng')
        batch_op.drop_column('lat')

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('topo_images', schema=None) as batch_op:
        batch_op.add_column(sa.Column('lat', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True))
        batch_op.add_column(sa.Column('lng', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True))

    with op.batch_alter_table('sectors', schema=None) as batch_op:
        batch_op.add_column(sa.Column('lat', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True))
        batch_op.add_column(sa.Column('lng', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True))

    with op.batch_alter_table('crags', schema=None) as batch_op:
        batch_op.add_column(sa.Column('lat', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True))
        batch_op.add_column(sa.Column('lng', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True))

    with op.batch_alter_table('areas', schema=None) as batch_op:
        batch_op.add_column(sa.Column('lat', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True))
        batch_op.add_column(sa.Column('lng', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True))

    # ### end Alembic commands ###
