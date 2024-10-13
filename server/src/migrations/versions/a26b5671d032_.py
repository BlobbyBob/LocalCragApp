"""empty message

Revision ID: a26b5671d032
Revises: 014dd3914ba1
Create Date: 2024-04-15 21:18:31.794547

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = 'a26b5671d032'
down_revision = '014dd3914ba1'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('areas', schema=None) as batch_op:
        batch_op.add_column(sa.Column('ascent_count', sa.Integer(), server_default='0', nullable=False))

    with op.batch_alter_table('crags', schema=None) as batch_op:
        batch_op.add_column(sa.Column('ascent_count', sa.Integer(), server_default='0', nullable=False))

    with op.batch_alter_table('regions', schema=None) as batch_op:
        batch_op.add_column(sa.Column('ascent_count', sa.Integer(), server_default='0', nullable=False))

    with op.batch_alter_table('sectors', schema=None) as batch_op:
        batch_op.add_column(sa.Column('ascent_count', sa.Integer(), server_default='0', nullable=False))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('sectors', schema=None) as batch_op:
        batch_op.drop_column('ascent_count')

    with op.batch_alter_table('regions', schema=None) as batch_op:
        batch_op.drop_column('ascent_count')

    with op.batch_alter_table('crags', schema=None) as batch_op:
        batch_op.drop_column('ascent_count')

    with op.batch_alter_table('areas', schema=None) as batch_op:
        batch_op.drop_column('ascent_count')

    # ### end Alembic commands ###
