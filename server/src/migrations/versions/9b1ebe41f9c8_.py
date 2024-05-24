"""empty message

Revision ID: 9b1ebe41f9c8
Revises: 7ea9ba093ff8
Create Date: 2024-05-02 22:34:36.123029

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '9b1ebe41f9c8'
down_revision = '7ea9ba093ff8'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('areas', schema=None) as batch_op:
        batch_op.add_column(sa.Column('secret', sa.Boolean(), nullable=True, server_default='0'))

    with op.batch_alter_table('crags', schema=None) as batch_op:
        batch_op.add_column(sa.Column('secret', sa.Boolean(), nullable=True, server_default='0'))

    with op.batch_alter_table('lines', schema=None) as batch_op:
        batch_op.add_column(sa.Column('secret', sa.Boolean(), nullable=True, server_default='0'))

    with op.batch_alter_table('sectors', schema=None) as batch_op:
        batch_op.add_column(sa.Column('secret', sa.Boolean(), nullable=True, server_default='0'))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('sectors', schema=None) as batch_op:
        batch_op.drop_column('secret')

    with op.batch_alter_table('lines', schema=None) as batch_op:
        batch_op.drop_column('secret')

    with op.batch_alter_table('crags', schema=None) as batch_op:
        batch_op.drop_column('secret')

    with op.batch_alter_table('areas', schema=None) as batch_op:
        batch_op.drop_column('secret')

    # ### end Alembic commands ###